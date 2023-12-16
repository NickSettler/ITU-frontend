//
//  Form.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Represents the data structure of a Form.
struct Form : Codable {

    // MARK: - Properties
    var form: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case form
        case name
    }

    // MARK: - Initializers
    /// Decodes the `Form` instance from a Decoder.
    /// - Parameter decoder: An instance of Decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.form = try container.decode(String.self, forKey: .form)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Initializes a `Form` instance with provided form structure.
    /// - Parameter form: Form as string.
    init(form: String) {
        self.init(form: form, name: form)
    }

    /// Initializes a `Form` instance with provided form structure and name.
    /// - Parameters:
    ///   - form: Form as string.
    ///   - name: Name of the Form
    init(form: String, name: String) {
        self.form = form
        self.name = name
    }

    // MARK: - Computed Properties
    /// Provides an empty instance of `Form`
    static var empty: Form {
        get {
            return .init(form: "", name: "")
        }
    }
}
