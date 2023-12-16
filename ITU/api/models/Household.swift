//
//  Household.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// Represents the data structure of a Household.
struct Household : Codable, Hashable {

    // MARK: - Properties
    var id: Int
    var user_created: User?
    var members: [User]
    
    enum CodingKeys: CodingKey {
        case id
        case user_created
        case members
    }

    // MARK: - Initializers
    /// Decodes the `Household` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        
        if let user_created = try? values.decodeIfPresent(User.self, forKey: .user_created) {
            self.user_created = user_created
        } else if let user_created = try? values.decodeIfPresent(String.self, forKey: .user_created) {
            self.user_created = .init(id: user_created)
        } else {
            self.user_created = nil
        }
        
        
        if let members = try? values.decodeIfPresent([User].self, forKey: .members) {
            self.members = members
        } else {
            self.members = []
        }
    }

    /// Initializes a `Household` instance with provided id, user created and members.
    /// - Parameters:
    ///   - id: Unique Identifier
    ///   - user_created: User who created this Household
    ///   - members: Members of this Household
    init(id: Int, user_created: User? = nil, members: [User]) {
        self.id = id
        self.user_created = user_created
        self.members = members
    }

    /// Initializes a `Household` instance with provided id.
    /// - Parameter id: Unique Identifier
    init(id: Int) {
        self.init(id: id, user_created: nil, members: [])
    }

    // MARK: - Instance Methods
    /// Compare two Households based on their ids
    static func == (lhs: Household, rhs: Household) -> Bool {
        return lhs.id == rhs.id
    }

    /// Hash Household by id, user_created and members
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(user_created)
        hasher.combine(members)
    }
}
