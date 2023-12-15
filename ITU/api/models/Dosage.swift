//
//  Dosage.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Dosage structure
struct Dosage : Codable {
    var form: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case form
        case name
    }

    /// Init dosage from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.form = try container.decode(String.self, forKey: .form)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init dosage with form
    /// - Parameter form: dosage form
    init(form: String) {
        self.init(form: form, name: form)
    }

    /// Init dosage with form and name
    /// - Parameters:
    ///   - form: dosage form
    ///   - name: dosage name
    init(form: String, name: String) {
        self.form = form
        self.name = name
    }
}
