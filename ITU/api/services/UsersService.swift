//
//  UsersService.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

struct UsersService {
    /// Get current user
    /// - Returns: current user
    static func getCurrentUser() async -> ApiSuccessResponse<User>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.get(
                path: "/users/me?fields=*.*.*",
                parameters: nil
            )
            
            let result: ApiSuccessResponse<User> = try NetworkAPI.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    /// Search users
    /// - Parameters:
    ///   - query: query to search
    /// - Returns: Array of users that match the query
    static func search(query: String) async -> ApiSuccessResponse<[User]>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.get(
                path: "/users?filter={ \"email\": { \"_contains\": \"\(query)\" }}",
                parameters: nil
            )
            
            let result: ApiSuccessResponse<[User]> = try NetworkAPI.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
