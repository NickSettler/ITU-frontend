//
//  Organization.swift
//  ITU
//
//  Created by Nikita Moiseev on 05.11.2023.
//

import Foundation

struct Organization : Codable {
    var code: String
    var country: Country
    var name: String
    var manufacturer: String?
    var holder: String?
}
