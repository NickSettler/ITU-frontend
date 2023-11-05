//
//  NetworkAPI.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import SwiftUI
import Foundation
import JWTDecode

class NetworkAPI {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) static var accessToken: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) static var refreshToken: String?
    
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
