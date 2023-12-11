//
//  Regex.swift
//  ITU
//
//  Created by Никита Моисеев on 11.12.2023.
//

import Foundation

let UUIDv4Regex = /^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12}$/

func matchesUUIDv4Regex(_ string: String) -> Bool { string.contains(UUIDv4Regex) }
