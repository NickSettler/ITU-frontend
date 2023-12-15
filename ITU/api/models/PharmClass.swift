//
//  PharmClass.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// PharmClass structure
struct PharmClass : Codable {
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }

    /// Init pharm class from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init pharm class with code
    /// - Parameter code: pharm class code
    init(code: String) {
        self.init(code: code, name: code)
    }

    /// Init pharm class with code and name
    /// - Parameters:
    ///   - code: pharm class code
    ///   - name: pharm class name
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
