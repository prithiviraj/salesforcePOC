//
//  LoginModel.swift
//  CanadaPOC
//
//  Created by CUBE84 on 15/02/21.
//

import Foundation

struct LoginModel: Codable {
    let access_token: String?
    let instance_url: String?
    let id: String?
    let token_type: String?
    let issued_at: String?
    let signature: String?
}
