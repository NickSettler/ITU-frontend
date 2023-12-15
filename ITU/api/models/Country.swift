//
//  Country.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Country structure
struct Country : Codable {
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    /// Init country from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init country with code
    /// - Parameter code: country code
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Init country with code and name
    /// - Parameters:
    ///   - code: country code
    ///   - name: country name
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
