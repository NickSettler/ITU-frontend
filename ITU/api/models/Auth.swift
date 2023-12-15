//
//  Auth.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

struct SignInResponse : Codable {
    let access_token: String
    let expires: Int
    let refresh_token: String
}

enum E_AUTH_STORAGE_KEYS : String {
    case ACCESS_TOKEN = "access_token"
    case REFRESH_TOKEN = "refresh_token"
}
