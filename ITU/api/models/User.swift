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
    var role: Role
    
    enum CodingKeys: CodingKey {
        case id
        case first_name
        case last_name
        case email
        case password
        case role
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.last_name = try values.decode(String.self, forKey: .last_name)
        self.email = try values.decode(String.self, forKey: .email)
        self.password = try values.decode(String.self, forKey: .password)
        
        if let role = try? values.decodeIfPresent(Role.self, forKey: .role) {
            self.role = role
        } else if let role = try? values.decodeIfPresent(String.self, forKey: .role) {
            self.role = .init(id: role)
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.role], debugDescription: "")
            )
        }
    }
    
    init(id: String) {
        self.init(id: id, first_name: "Test", last_name: "Test", email: "test@localhost", password: "********", role: .init(id: "test"))
    }
    
    init(id: String, first_name: String, last_name: String, email: String, password: String, role: Role) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.role = role
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
