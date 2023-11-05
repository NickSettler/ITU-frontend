//
//  Organization.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

struct Organization : Decodable {
    var code: String
    var country: Country
    var name: String
    var manufacturer: String?
    var holder: String?
}
