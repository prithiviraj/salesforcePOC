//
//  BaseResponse.swift
//  CanadaPOC
//
//  Created by CUBE84 on 17/02/21.
//

import Foundation
import ObjectMapper
class BaseResponse: Mappable {
    var msg: String?
    var status: String?
    var token: String?
    var secret: String?
    var key: String?
    var errorCode: Int?
    var loginModel: LoginModel?
    var access_token: String?
    var instance_url: String?
    var id: String?
    var token_type: String?
    var issued_at: String?
    var signature: String?

    required init?(map: Map){}
    required init?(){}
    func mapping(map: Map) {
        msg <- map["msg"]
        status <- map["status"]
        errorCode <- map["errorCode"]
        token <- map["token"]
        key <- map["key"]
        secret <- map["secret"]
        access_token <- map["access_token"]
         instance_url <- map["instance_url"]
         id <- map["id"]
         token_type <- map["token_type"]
         issued_at <- map["issued_at"]
         signature <- map["signature"]

       
    }
}


