//
//  Dosage.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

struct Dosage : Codable {
    var form: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case form
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.form = try container.decode(String.self, forKey: .form)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(form: String) {
        self.init(form: form, name: form)
    }
    
    init(form: String, name: String) {
        self.form = form
        self.name = name
    }
}
