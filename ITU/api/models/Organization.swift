//
//  Organization.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Organization structure
struct Organization : Codable {
    var code: String
    var country: Country
    var name: String
    var manufacturer: String?
    var holder: String?
    
    enum CodingKeys: CodingKey {
        case code
        case country
        case name
        case manufacturer
        case holder
    }

    /// Init organization from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        
        if let country = try? container.decodeIfPresent(Country.self, forKey: .country) {
            self.country = country
        } else if let country = try? container.decodeIfPresent(String.self, forKey: .country) {
            self.country = .init(code: country)
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.country], debugDescription: "")
            )
        }
        
        self.name = try container.decode(String.self, forKey: .name)
        self.manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
        self.holder = try container.decodeIfPresent(String.self, forKey: .holder)
    }

    /// Init organization with code
    /// - Parameter code: organization code
    init(code: String) {
        self.init(
            code: code,
            country: .init(code: code),
            name: code
        )
    }

    /// Init organization with code, country, name, manufacturer and holder
    /// - Parameters:
    ///   - code: organization code
    ///   - country: organization country
    ///   - name: organization name
    ///   - manufacturer: organization manufacturer
    ///   - holder: organization holder
    init(code: String, country: Country, name: String, manufacturer: String? = nil, holder: String? = nil) {
        self.code = code
        self.country = country
        self.name = name
        self.manufacturer = manufacturer
        self.holder = holder
    }
}
