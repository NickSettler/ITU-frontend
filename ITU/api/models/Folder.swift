//
//  Folder.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct Folder : Codable, Identifiable, Equatable {
    var id: String
    var name: String
    var sort: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case sort
    }
    
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.id == rhs.id
    }
}


typealias GetAllUserFoldersResponse = [Folder]

let defaultFolders: [Folder] = [
    .init(id: "ALL", name: "All", sort: 1)
]
