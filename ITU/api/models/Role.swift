//
//  Role.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct Role : Codable, Hashable {
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
        self.init(id: id, name: "Role", icon: "icon", enforce_tfa: false, admin_access: false, app_access: false, users: [])
    }
    
    init(
        id: String,
        name: String,
        icon: String,
        description: String? = nil,
        ip_access: String? = nil,
        enforce_tfa: Bool,
        admin_access: Bool,
        app_access: Bool,
        users: [String]
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.description = description
        self.ip_access = ip_access
        self.enforce_tfa = enforce_tfa
        self.admin_access = admin_access
        self.app_access = app_access
        self.users = users
    }
    
    static func == (lhs: Role, rhs: Role) -> Bool {
        return lhs.id == rhs.id
    }
}
