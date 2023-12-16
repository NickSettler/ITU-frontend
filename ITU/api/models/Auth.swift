//
//  Auth.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

/// Struct model for Sign In responses.
/// This is used to parse the JSON response returned from sign in requests.
struct SignInResponse : Codable {
    /// The access token assigned when authentication is successful
    let access_token: String
    /// The duration, in seconds, in which the token is set to expire
    let expires: Int
    /// The token that's used to refresh the session when the access token expires
    let refresh_token: String
}

/// Enum storing the key names for storing user authentication tokens.
/// The keys are used with the AppStorage property wrapper to store data
/// persistent between runs and is used to keep the user signed in between app sessions.
enum E_AUTH_STORAGE_KEYS : String {
    /// The Storage Key for the Access Token
    case ACCESS_TOKEN = "access_token"
    /// The Storage Key for the Refresh Token
    case REFRESH_TOKEN = "refresh_token"
}
