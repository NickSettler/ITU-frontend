//
//  Auth.swift
//  ITU
//
//  Created by Nikita Moiseev on 25.10.2023.
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
