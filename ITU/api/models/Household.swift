//
//  Household.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

struct Household : Codable, Hashable {
    var id: Int
    var user_created: User?
    var members: [User]
    
    enum CodingKeys: CodingKey {
        case id
        case user_created
        case members
    }
    
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
    
    init(id: Int, user_created: User? = nil, members: [User]) {
        self.id = id
        self.user_created = user_created
        self.members = members
    }
    
    init(id: Int) {
        self.init(id: id, user_created: nil, members: [])
    }
    
    static func == (lhs: Household, rhs: Household) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(user_created)
        hasher.combine(members)
    }
}
