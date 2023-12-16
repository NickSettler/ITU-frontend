//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a Unit.
/// It conforms to Codable for ease of parsing
struct Unit : Codable {

    // MARK: - Properties
    var unit: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case unit
        case name
    }

    // MARK: - Initializers
    /// Decodes the `Unit` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unit = try container.decode(String.self, forKey: .unit)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Unit` instance with provided unit string.
    /// - Parameter unit: Unit as string.
    init(unit: String) {
        self.init(unit: unit, name: unit)
    }

    /// Initializes a `Unit` instance with provided unit string and name.
    /// - Parameters:
    ///   - unit: Unit as string.
    ///   - name: Name of the Unit
    init(unit: String, name: String) {
        self.unit = unit
        self.name = name
    }
}
