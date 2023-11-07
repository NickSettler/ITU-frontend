//
//  User.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct User : Codable, Hashable {
    var id: String
    var first_name: String
    var last_name: String
    var email: String
    var password: String
    var location: String?
    var title: String?
    var description: String?
    var language: String?
    var tfa_secret: String?
    var status: String?
    var last_access: String?
    var last_page: String?
    var provider: String?
    var email_notifications: Bool
    var role: Role
    
    enum CodingKeys: CodingKey {
        case id
        case first_name
        case last_name
        case email
        case password
        case location
        case title
        case description
        case language
        case tfa_secret
        case status
        case last_access
        case last_page
        case provider
        case email_notifications
        case role
    }
    
    init(id: String) {
        self.init(id: id, first_name: "Test", last_name: "Test", email: "test@localhost", password: "********", email_notifications: false, role: .init(id: "test"))
    }
    
    init(id: String, first_name: String, last_name: String, email: String, password: String, location: String? = nil, title: String? = nil, description: String? = nil, language: String? = nil, tfa_secret: String? = nil, status: String? = nil, last_access: String? = nil, last_page: String? = nil, provider: String? = nil, email_notifications: Bool, role: Role) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.location = location
        self.title = title
        self.description = description
        self.language = language
        self.tfa_secret = tfa_secret
        self.status = status
        self.last_access = last_access
        self.last_page = last_page
        self.provider = provider
        self.email_notifications = email_notifications
        self.role = role
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
