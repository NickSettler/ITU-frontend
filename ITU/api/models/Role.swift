//
//  Role.swift
//  ITU
//
//  Created by Nikita Moiseev
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
    var users: [User]
    
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.icon = try values.decode(String.self, forKey: .icon)
        self.description = try? values.decodeIfPresent(String.self, forKey: .description)
        self.ip_access = try? values.decodeIfPresent(String.self, forKey: .ip_access)
        
        if let enforce_tfa = try values.decodeIfPresent(Bool.self, forKey: .enforce_tfa) {
            self.enforce_tfa = enforce_tfa
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.enforce_tfa], debugDescription: "")
            )
        }
        
        if let admin_access = try values.decodeIfPresent(Bool.self, forKey: .admin_access) {
            self.admin_access = admin_access
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.admin_access], debugDescription: "")
            )
        }
        
        if let app_access = try values.decodeIfPresent(Bool.self, forKey: .app_access) {
            self.app_access = app_access
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.app_access], debugDescription: "")
            )
        }
        
        if let users = try values.decodeIfPresent([User].self, forKey: .users) {
            self.users = users
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.users], debugDescription: "")
            )
        }
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
        self.users = users.map { .init(id: $0) }
    }
    
    static func == (lhs: Role, rhs: Role) -> Bool {
        return lhs.id == rhs.id
    }
}
