//
//  Folder.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct Folder : Codable, Identifiable, Equatable, Hashable {
    var id: String
    var name: String
    var icon: String?
    var sort: Int?
    var user_created: User
    var date_created: String
    var user_updated: User?
    var date_updated: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case icon
        case sort
        case user_created
        case date_created
        case user_updated
        case date_updated
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id)!
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!
        self.icon = try? values.decodeIfPresent(String.self, forKey: .icon)
        self.sort = try values.decodeIfPresent(Int.self, forKey: .sort) ?? 1
        
        if let user_created = try? values.decodeIfPresent(User.self, forKey: .user_created) {
            self.user_created = user_created
        } else if let user_created = try? values.decodeIfPresent(String.self, forKey: .user_created) {
            self.user_created = .init(id: user_created)
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.user_created], debugDescription: "")
            )
        }
        if let user_updated = try? values.decodeIfPresent(User.self, forKey: .user_updated) {
            self.user_updated = user_updated
        } else if let user_updated = try? values.decodeIfPresent(String.self, forKey: .user_updated) {
            self.user_updated = .init(id: user_updated)
        } else {
            self.user_updated = nil
        }
        
        self.date_created = try values.decodeIfPresent(String.self, forKey: .date_created)!
        self.date_updated = try values.decodeIfPresent(String.self, forKey: .date_updated) ?? nil
    }
    
    init (id: String) {
        self.init(id: id, name: id, icon: id, user_created: .init(id: id), date_created: "")
    }
    
    init(
        id: String,
        name: String,
        icon: String,
        sort: Int? = nil,
        user_created: User,
        date_created: String,
        user_updated: User? = nil,
        date_updated: String? = nil
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.sort = sort
        self.user_created = user_created
        self.date_created = date_created
        self.user_updated = user_updated
        self.date_updated = date_updated
    }
    
    static var allFolder: Folder {
        get {
            .init(id: "ALL", name: "All", icon: "", sort: 0, user_created: .init(id: "test"), date_created: "")
        }
    }
    
    static var empty: Folder {
        get {
            .init(id: "", name: "", icon: "", sort: 0, user_created: .init(id: ""), date_created: "")
        }
    }
    
    var isEmpty: Bool {
        return self.id == "";
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.id == rhs.id
    }
}


typealias GetAllUserFoldersResponse = [Folder]
