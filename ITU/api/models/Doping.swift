//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// RegistraionStatus structure
struct Doping : Codable {
    var doping: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case doping
        case name
    }

    /// Init registraion status from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.doping = try container.decode(String.self, forKey: .doping)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init registraion status with code
    /// - Parameter doping: registraion status code
    init(doping: String) {
        self.init(doping: doping, name: doping)
    }

    /// Init registraion status with code and name
    /// - Parameters:
    ///   - code: registraion status code
    ///   - name: registraion status name
    init(doping: String, name: String) {
        self.doping = doping
        self.name = name
    }
}
