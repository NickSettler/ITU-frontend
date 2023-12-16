//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a RegistrationStatus.
struct RegistraionStatus : Codable {

    // MARK: - Properties
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    // MARK: - Initializers
    /// Decodes the `RegistraionStatus` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `RegistraionStatus` instance with provided code.
    /// - Parameter code: Code as string.
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Initializes a `RegistraionStatus` instance with provided code and name.
    /// - Parameters:
    ///   - code: Code as string.
    ///   - name: Name of the RegistrationStatus
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
