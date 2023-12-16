//
//  Regex.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

/// Regular expression pattern to validate UUIDv4 string
let UUIDv4Regex = /^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-4[0-9A-Fa-f]{3}-[89ABab][0-9A-Fa-f]{3}-[0-9A-Fa-f]{12}$/

/// Function to evaluate if a string matches the UUIDv4 regex
/// - Parameter string: String to be checked
/// - Returns: True if the string is a UUIDv4, false otherwise
func matchesUUIDv4Regex(_ string: String) -> Bool { string.contains(UUIDv4Regex) }
