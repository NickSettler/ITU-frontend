//
//  Country.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// `Country` struct used to represent a country fetched from an API.
/// This struct is decodable which allows for an instance of `Country`
/// to be directly initialized with the data from a JSON response.
struct Country : Codable {
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    /// Initializes a `Country` instance from a decoder (used for API response parsing).
    ///
    /// - Parameter decoder: Decoder instance to decode the JSON response.
    ///
    /// - Throws: Throws an error if there are missing keys in the JSON response.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Country` instance with a specified code.
    /// The name of the country will also be set to the provided code.
    ///
    /// - Parameter code: A string that represents the country's code.
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Initializes a `Country` instance with a specified code and name.
    ///
    /// - Parameters:
    ///   - code: A string that represents the country's code.
    ///   - name: A string that represents the country's name.
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
