//
//  Constant.swift
//  CanadaPOC
//
//  Created by CUBE84 on 14/02/21.
//

import Foundation

var token: String = ""

struct K {
    struct ProductionServer {
        static let baseURL = "http://itechnodev.com/api"
        static let salesforceTokenURL = "https://test.salesforce.com/services/oauth2/token"
        static let postCase = "https://unionsquare--cube84dev.my.salesforce.com/services/data/v20.0/sobjects/Case/"
    }
    
    struct LoginCreditionals {
        static let username = "cube84user@unionsquarefoundation.org.cube84dev"
        static let password = "Spring@84"
        static let grant_type = "password"
        static let client_id = "3MVG9FG3dvS828gLnnDEJ_qFiMlKjAAbZ39DBQQPGE8JCrlWTo0uPhZeN5AojN6y.jbJcMfIpnZH7YPMVNc6_"
        static let client_secret = "D4C66124B6CD98C19323097E6FB9C80F604BCE05F39E34E96B8F0449F0B0186E"
    }
    
    struct  APIParameterKey {
        static let username = "username"
        static let password = "password"
        static let grant_type = "password"
        static let client_id = "password"
        static let client_secret = "password"
        
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded"
}
