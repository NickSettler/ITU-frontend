//
//  Route.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a Route.
/// It conforms to Codable for ease of parsing
struct Route : Codable {

    // MARK: - Properties
    var route: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case route
        case name
    }

    // MARK: - Initializers
    /// Decodes the `Route` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.route = try container.decode(String.self, forKey: .route)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Route` instance with provided route string.
    /// - Parameter route: Route as string.
    init(route: String) {
        self.init(route: route, name: route)
    }

    /// Initializes a `Route` instance with provided route string and name.
    /// - Parameters:
    ///   - route: Route as string.
    ///   - name: Name of the route
    init(route: String, name: String) {
        self.route = route
        self.name = name
    }
}
