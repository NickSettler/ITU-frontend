//
//  Route.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct Route : Codable {
    var route: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case route
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.route = try container.decode(String.self, forKey: .route)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(route: String) {
        self.init(route: route, name: route)
    }
    
    init(route: String, name: String) {
        self.route = route
        self.name = name
    }
}
