//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// RegistraionStatus structure
struct Unit : Codable {
    var unit: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case unit
        case name
    }

    /// Init registraion status from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unit = try container.decode(String.self, forKey: .unit)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init registraion status with code
    /// - Parameter unit: registraion status code
    init(unit: String) {
        self.init(unit: unit, name: unit)
    }

    /// Init registraion status with code and name
    /// - Parameters:
    ///   - unit: registraion status code
    ///   - name: registraion status name
    init(unit: String, name: String) {
        self.unit = unit
        self.name = name
    }
}
