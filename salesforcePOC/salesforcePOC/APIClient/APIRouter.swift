//
//  APIRouter.swift
//  CanadaPOC
//
//  Created by CUBE84 on 14/02/21.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(username:String, password:String,grant_type:String,client_id:String,client_secret:String)
    case articles
    case article(id: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .articles, .article:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return K.ProductionServer.salesforceTokenURL
        case .articles:
            return "/articles/all.json"
        case .article(let id):
            return "/article/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let username, let password,let grant_type,let client_id,let client_secret):
            return ["username": username, "password": password,"grant_type":grant_type, "client_id":client_id,"client_secret":client_secret]
        case .articles, .article:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var url: URL
        var urlRequest: URLRequest
        if path == K.ProductionServer.salesforceTokenURL {
            url = try K.ProductionServer.salesforceTokenURL.asURL()
            urlRequest = URLRequest(url:url)
        }else{
            url = try K.ProductionServer.baseURL.asURL()
            urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
        print("path:: ====\(path)")
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.urlencoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
