//
//  Role.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a Role.
struct Role : Codable, Hashable {

    // MARK: - Properties
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

    // MARK: - Initializers
    /// Decodes the `Role` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
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

    /// Initializes a `Role` instance with id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access and users
    /// - Parameters:
    ///   - id: Unique identifier for the Role
    ///   - name: Name of the Role
    ///   - icon: Represents an icon for the Role
    ///   - description: A brief description about the Role
    ///   - ip_access: Represents IP access for the Role
    ///   - enforce_tfa: Flag to enforce Two Factor Authentication for the Role
    ///   - admin_access: Flag to provide admin access for the Role
    ///   - app_access: Flag to provide app access for the Role
    ///   - users: List of users having this Role
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

    // MARK: - Instance Methods
    /// Compare two Roles based on their ids
    static func == (lhs: Role, rhs: Role) -> Bool {
        return lhs.id == rhs.id
    }
}
