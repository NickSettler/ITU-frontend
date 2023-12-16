//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Addiction structure
///
/// - Author: Nikita Moiseev
///
/// Struct used to represent Addiction status fetched from API.
/// Conformance to Codable provides encoding and decoding functionalities.
struct Addiction : Codable {
    /// Represents the code of the Addiction status
    var code: String
    /// Represents the name of the Addiction status
    var name: String
    
    /// CodingKeys enum for decoding purposes
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    /// Init an Addiction instance from decoder (used for API response parsing)
    ///
    /// - Parameters:
    ///   - decoder: Decoder instance to decode the JSON response
    ///
    /// - Throws: An error if there are missing keys in the JSON response
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init Addition instance with code
    ///
    /// - Parameters:
    ///   - code: The Addiction status code
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Init Addition instance with code and name
    ///
    /// - Parameters:
    ///   - code: The Addiction status code
    ///   - name: The Addiction status name
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
