//
//  RegistraionStatus.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// RegistraionStatus structure
struct LegalRegistrationBase : Codable {
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    /// Init registraion status from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init registraion status with code
    /// - Parameter code: registraion status code
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Init registraion status with code and name
    /// - Parameters:
    ///   - code: registraion status code
    ///   - name: registraion status name
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
