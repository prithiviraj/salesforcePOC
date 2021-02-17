//
//  APIClient2.swift
//  CanadaPOC
//
//  Created by CUBE84 on 17/02/21.
//

import Foundation
import Alamofire
import ObjectMapper

class APIClient {
    var isTokenExpired = 0
    class var getInstance: APIClient {
        struct Static {
            static let instance: APIClient = APIClient()
        }
        return Static.instance
    }
    let headers : HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    func makeNetWorkCall(url: String, method: HTTPMethod, parameters: Parameters, successResponse: @escaping ((AnyObject) -> Void), errorResponse: @escaping ((AnyObject, String) -> Void)) {
        var header = HTTPHeaders()
        var encoding = URLEncoding.default
        var param =  Parameters()
        if url == K.ProductionServer.salesforceTokenURL {
            header = headers
            encoding = URLEncoding.default
            param = parameters
        } else {
            let headersWithToken : HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            ]
            param = [:]
            header = headersWithToken
        }
        let parameters = createJSONParameterString(postBody: parameters as AnyObject)
        print("-R-url->\(url)")
        print("-R-header->\(header)")
        print("-R-parameters->\(param)")
        print("-R-body->\(parameters)")
        AF.request(url, method: .post, parameters: param, encoding: param.count > 0 ? encoding : BodyStringEncoding(body: parameters), headers: header).responseString { response in
            print("API-response-statusCode>\(response.response?.statusCode ?? 0)")
            print("API-response->\(response)")
            switch response.result {
            case .success:
                print("success")
                guard let value = response.value else {
                    successResponse(response.value as AnyObject)
                    return
                }
                successResponse(value as AnyObject)
            case .failure(let error):
                print(error)
                let errorMessage = self.getErrorMessage(response: error as NSError)
                errorResponse(error as AnyObject, errorMessage)
            }
        }
    }
    
    //MARK:- Create JSON String
            func createJSONParameterString(postBody:AnyObject) -> String {

                if let objectData = try? JSONSerialization.data(withJSONObject: postBody, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                    let objectString = String(data: objectData, encoding: .utf8)
                    return objectString ?? ""
                }
                return ""
            }
    
    func getErrorMessage(response: NSError) -> String {
        var errorMessage = CPMessage.ServiceError.UNKNOWN_ERROR
        let responseCode = response.code
        switch responseCode {
        case NSURLErrorNetworkConnectionLost:
            errorMessage = CPMessage.ServiceError.NO_INTERNET_CONNECTION
        case NSURLErrorNotConnectedToInternet:
            errorMessage = "The Internet connection appears to be offline."
        case NSURLErrorTimedOut:
            errorMessage = "The request timed out."
        default:
            errorMessage = CPMessage.ServiceError.UNKNOWN_ERROR
        }
        return errorMessage
    }
}
struct BodyStringEncoding: ParameterEncoding {

    private let body: String

    init(body: String) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyURLRequest: return "Empty url request"
            case .encodingProblem: return "Encoding problem"
        }
    }
}
