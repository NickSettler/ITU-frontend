//
//  User.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

struct User : Codable {
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
        self.id = id
        self.first_name = "Test"
        self.last_name = "Test"
        self.email = "test@localhost"
        self.password = "*****"
        self.email_notifications = false
        self.role = .init(id: "68e30277-d231-498d-bb37-9c124e60a38c")
    }
}
