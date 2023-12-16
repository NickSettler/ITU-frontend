//
//  User.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a User.
/// It conforms to Codable and Hashable.
class User : Codable, Hashable {

    // MARK: - Properties
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

    // MARK: - Initializers
    /// Decodes the `User` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
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

    /// Initializes a `User` instance with provided id.
    /// - Parameter id: Id as string.
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

    /// Initializes a `User` instance with provided details like id, email etc.
    /// - Parameters:
    ///   - id: Unique identifier for the User
    ///   - first_name: FirstName of the User
    ///   - last_name: LastName of the User
    ///   - email: Email Id for the User
    ///   - password: Password for the User
    ///   - role: Role of the User
    ///   - household: Household of the User
    init(id: String, first_name: String, last_name: String, email: String, password: String, role: Role, household: Household) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.role = role
        self.household = household
    }

    // MARK: - Instance Methods
    /// Compare two Users based on their ids
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    /// Hash a User based on id
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
