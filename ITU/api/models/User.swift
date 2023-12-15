//
//  User.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// User structure
class User : Codable, Hashable {
    var id: String
    var first_name: String?
    var last_name: String?
    var email: String
    var password: String
    var role: Role
    var household: Household?
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case email
        case password
        case role
        case household = "household"
    }

    /// Init user from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.first_name = try? values.decode(String.self, forKey: .first_name)
        self.last_name = try? values.decode(String.self, forKey: .last_name)
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
        
        if let household = try? values.decodeIfPresent(Household.self, forKey: .household) {
            self.household = household
        } else if let household = try? values.decodeIfPresent(Int.self, forKey: .household) {
            self.household = .init(id: household)
        } else {
            self.household = nil
        }
    }

    /// Init user with id
    /// - Parameter id: user id
    convenience init(id: String) {
        self.init(
            id: id,
            first_name: "",
            last_name: "",
            email: "",
            password: "",
            role: .init(id: ""),
            household: .init(id: -1)
        )
    }

    /// Init user with id, first_name, last_name, email, password, role and household
    /// - Parameters:
    ///   - id: user id
    ///   - first_name: user first name
    ///   - last_name: user last name
    ///   - email: user email
    ///   - password: user password
    ///   - role: user role
    ///   - household: user household
    init(id: String, first_name: String, last_name: String, email: String, password: String, role: Role, household: Household) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.role = role
        self.household = household
    }

    /// Compare two users by id
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    /// Hash user by id
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
