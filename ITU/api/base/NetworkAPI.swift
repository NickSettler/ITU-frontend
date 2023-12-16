//
//  NetworkAPI.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI
import Foundation
import JWTDecode


/// Network operations handler class
///
/// - Author: Nikita Moiseev
class NetworkAPI {
    // Defines storage for access and refresh token
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) static var accessToken: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) static var refreshToken: String?

    /// Checks if a JWT token is expired
    ///
    /// - Parameters:
    ///     - token: JWT token as a string
    ///
    /// - Returns: Boolean, true if token is expired, false otherwise
    static func isTokenExpired(token: String) -> Bool {
        guard let decodedToken = try? decode(jwt: token) else {
            return true
        }
        
        guard let exp = decodedToken.body["exp"] as? Int else {
            return true
        }
        
        let timeInterval = TimeInterval(exp)
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return date < Date.now
    }

    /// Parses JSON data from response
    ///
    /// - Parameters:
    ///     - data: Raw server response data
    ///
    /// - Throws: Error if data is not decodable into the provided type
    ///
    /// - Returns: Data decoded into the provided type
    static func parseData<T: Decodable>(data: Data) throws -> T{
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch {
            print(error)
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
    }
}
