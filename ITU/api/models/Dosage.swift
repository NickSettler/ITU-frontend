//
//  Dosage.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// `Dosage` struct used to represent a dosage form fetched from an API.
/// This struct is decodable which allows for direct initialization from
/// the data associated with a JSON response.
struct Dosage : Codable {
    var form: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case form
        case name
    }

    /// Initializes a `Dosage` instance from a decoder (used for API response parsing).
    ///
    /// - Parameter decoder: Decoder instance to decode the JSON response.
    ///
    /// - Throws: Throws an error if there are missing keys in the JSON response.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.form = try container.decode(String.self, forKey: .form)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Dosage` instance with a specified form.
    /// The name of the dosage will also be set to the provided form.
    ///
    /// - Parameter form: A string that represents the dosage form.
    init(form: String) {
        self.init(form: form, name: form)
    }

    /// Initializes a `Dosage` instance with specified form and name.
    ///
    /// - Parameters:
    ///   - form: A string that represents the dosage form.
    ///   - name: A string that represents the dosage name.
    init(form: String, name: String) {
        self.form = form
        self.name = name
    }
}
