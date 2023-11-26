//
//  PharmClass.swift
//  ITU
//
//  Created by Никита Моисеев on 26.11.2023.
//

import Foundation

struct PharmClass : Codable {
    var code: String
    var name: String
    
    enum CodingKeys: CodingKey {
        case code
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(code: String) {
        self.init(code: code, name: code)
    }
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}