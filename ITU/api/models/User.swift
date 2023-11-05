//
//  User.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

struct User : Decodable {
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
}
