//
//  Role.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

struct Role : Decodable {
    var id: String
    var name: String
    var icon: String
    var description: String?
    var ip_access: String?
    var enforce_tfa: Bool
    var admin_access: Bool
    var app_access: Bool
    var users: [String]
}
