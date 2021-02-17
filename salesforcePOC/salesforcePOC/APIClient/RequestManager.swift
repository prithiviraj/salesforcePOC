//
//  RequestManager.swift
//  CanadaPOC
//
//  Created by CUBE84 on 17/02/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class RequestManager {
    
    var urlPath: String = ""
    var params: ([String: Any]?)
    var method: HTTPMethod? = nil
    
    class var getInstance: RequestManager {
        // Dont use static
        //        struct Static {
        //            static let instance: RequestManager = RequestManager()
        //        }
        //        return Static.instance
        return RequestManager()
    }
    init(){}
}

//MARK: AUTH WS Call
extension RequestManager {
    func postLogin(username : String,password : String,grant_type : String,client_id : String,client_secret : String, success: @escaping ((AnyObject)->Void), error: @escaping ((AnyObject)->Void)) {
        let urlPath = K.ProductionServer.salesforceTokenURL
        let parameters = [
            "username": username,
            "password": password,
            "grant_type": grant_type,
            "client_id": client_id,
            "client_secret": client_secret,
        ]
        APIClient.getInstance.makeNetWorkCall(url: urlPath, method: HTTPMethod.post, parameters: parameters, successResponse: { (successResponse: AnyObject) in
            let res = Mapper<BaseResponse>().map(JSONString: successResponse as! String)
            success(res ?? AnyObject.self as AnyObject)
        }) { (errorResponse: AnyObject, errorMessage) in
            print("errorResponse->\(errorResponse)")
            error(errorResponse)
        }
    }
    
    func postCase(Case_Type_District360__c: String, Sub_type_District360__c: String, Status: String, Priority: String, success: @escaping ((AnyObject)->Void), error: @escaping ((AnyObject)->Void)) {
        let urlPath = K.ProductionServer.postCase
        let parameters = [
            "Case_Type_District360__c": Case_Type_District360__c,
            "Sub_type_District360__c": Sub_type_District360__c,
            "Status": Status,
            "Priority": Priority,
        ]
        APIClient.getInstance.makeNetWorkCall(url: urlPath, method: HTTPMethod.post, parameters: parameters, successResponse: { (successResponse: AnyObject) in
            let res = Mapper<BaseResponse>().map(JSONString: successResponse as! String)
            success(res ?? AnyObject.self as AnyObject)
        }) { (errorResponse: AnyObject, errorMessage) in
            print("errorResponse->\(errorResponse)")
            error(errorResponse)
        }
    }
}
