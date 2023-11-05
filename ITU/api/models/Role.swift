//
//  Role.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

struct Role : Codable {
    var id: String
    var name: String
    var icon: String
    var description: String?
    var ip_access: String?
    var enforce_tfa: Bool
    var admin_access: Bool
    var app_access: Bool
    var users: [String]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case icon
        case description
        case ip_access
        case enforce_tfa
        case admin_access
        case app_access
        case users
    }
    
    init(id: String) {
        self.id = id
        self.name = "Role"
        self.icon = "icon"
        self.enforce_tfa = false
        self.admin_access = false
        self.app_access = false
        self.users = []
    }
}
