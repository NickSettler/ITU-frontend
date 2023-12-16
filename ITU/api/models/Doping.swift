//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// `Doping` struct used to represent a doping status fetched from an API.
/// This struct is decodable which allows for direct initialization from
/// the data associated with a JSON response.
struct Doping : Codable {
    var doping: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case doping
        case name
    }

    /// Initializes a `Doping` instance from a decoder (used for API response parsing).
    ///
    /// - Parameter decoder: Decoder instance to decode the JSON response.
    ///
    /// - Throws: Throws an error if there are missing keys in the JSON response.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.doping = try container.decode(String.self, forKey: .doping)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Doping` instance with a specified doping.
    /// The name of the doping status will also be set to the provided doping.
    ///
    /// - Parameter doping: A string that represents the doping status.
    init(doping: String) {
        self.init(doping: doping, name: doping)
    }

    /// Initializes a `Doping` instance with specified doping and name.
    ///
    /// - Parameters:
    ///   - doping: A string that represents the doping status.
    ///   - name: A string that represents the status name.
    init(doping: String, name: String) {
        self.doping = doping
        self.name = name
    }
}
