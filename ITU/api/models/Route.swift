//
//  Route.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Route structure
struct Route : Codable {
    var route: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case route
        case name
    }

    /// Init route from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.route = try container.decode(String.self, forKey: .route)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init route with route
    /// - Parameter route: route
    init(route: String) {
        self.init(route: route, name: route)
    }

    /// Init route with route and name
    /// - Parameters:
    ///   - route: route
    ///   - name: name
    init(route: String, name: String) {
        self.route = route
        self.name = name
    }
}
