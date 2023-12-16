//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a Hormone.
/// It conforms to Codable for ease of parsing
struct Hormone : Codable {

    // MARK: - Properties
    var code: String
    var name: String

    enum CodingKeys: CodingKey {
        case code
        case name
    }

    // MARK: - Initializers
    /// Decodes the `Hormone` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Hormone` instance with provided code.
    /// - Parameter code: Code as string.
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Initializes a `Hormone` instance with provided code and name.
    /// - Parameters:
    ///   - code: Code as string.
    ///   - name: Name of the Hormone
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
