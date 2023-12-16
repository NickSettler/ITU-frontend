//
//  Folder.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

/// Represents the data structure of a Folder.
/// It conforms to Codable, Identifiable, Equatable and Hashable for ease of
/// parsing, list handling and comparison.
struct Folder : Codable, Identifiable, Equatable, Hashable {

    // MARK: - Properties
    var id: String
    var name: String
    var icon: String?
    var isPrivate: Bool
    var description: String?
    var sort: Int?
    var user_created: User
    var date_created: String
    var user_updated: User?
    var date_updated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case isPrivate = "private"
        case description
        case sort
        case user_created
        case date_created
        case user_updated
        case date_updated
    }

    // MARK: - Initializers
    /// Decodes the `Folder` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id)!
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!
        self.icon = try? values.decodeIfPresent(String.self, forKey: .icon)
        self.isPrivate = (try? values.decode(Bool.self, forKey: .isPrivate)) ?? false
        self.description = try? values.decodeIfPresent(String.self, forKey: .description)
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

    /// Initializes a `Folder` instance with provided id.
    /// - Parameter id: Unique identifier.
    init (id: String) {
        self.init(id: id, name: id, icon: id, isPrivate: false, user_created: .init(id: id), date_created: "")
    }

    /// Initializes a `Folder` instance with provided informations.
    /// - Parameters:
    ///   - id: Unique ientifier.
    ///   - name: Name of the Folder
    ///   - icon: Icon for the Folder
    ///   - sort: Sorting index for the Folder
    ///   - isPrivate: Specifies if Folder is private
    ///   - user_created: User who created this Folder
    ///   - date_created: Date when this Folder was created
    ///   - user_updated: User who updated this Folder
    ///   - date_updated: Date when this Folder was updated
    init(
        id: String,
        name: String,
        icon: String,
        sort: Int? = nil,
        isPrivate: Bool,
        user_created: User,
        date_created: String,
        user_updated: User? = nil,
        date_updated: String? = nil
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.isPrivate = isPrivate
        self.sort = sort
        self.user_created = user_created
        self.date_created = date_created
        self.user_updated = user_updated
        self.date_updated = date_updated
    }

    // MARK: - Computed Properties
    /// Provides an instance of `Folder` that represents all Folders.
    static var allFolder: Folder {
        get {
            .init(id: "ALL", name: "All", icon: "", sort: 0, isPrivate: false, user_created: .init(id: "test"), date_created: "")
        }
    }

    // Provides an empty instance of `Folder`
    static var empty: Folder {
        get {
            .init(id: "", name: "", icon: "", sort: 0, isPrivate: false, user_created: .init(id: ""), date_created: "")
        }
    }
    
    var isEmpty: Bool {
        return self.id == "";
    }

    /// Compare two folders by id
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.id == rhs.id
    }
}


typealias GetAllUserFoldersResponse = [Folder]
