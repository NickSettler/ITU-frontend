//
//  Form.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Form structure
struct Form : Codable {
    var form: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case form
        case name
    }

    /// Init form from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.form = try container.decode(String.self, forKey: .form)
        self.name = try container.decode(String.self, forKey: .name)
    }

    /// Init form with form
    /// - Parameter form: form
    init(form: String) {
        self.init(form: form, name: form)
    }

    /// Init form with form and name
    /// - Parameters:
    ///   - form: form
    ///   - name: name
    init(form: String, name: String) {
        self.form = form
        self.name = name
    }
    
    static var empty: Form {
        get {
            return .init(form: "", name: "")
        }
    }
}
