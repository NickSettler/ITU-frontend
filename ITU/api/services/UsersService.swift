//
//  UsersService.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// `UsersService` is a struct that contains all operations related to users.
struct UsersService {

    /// Fetches the current logged in user
    ///
    /// - Returns: An instance of `ApiSuccessResponse<User>` type on success, nil on failure
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

    /// Searches users by the given query
    ///
    /// - Parameters:
    ///   - query: The search term as string
    ///
    /// - Returns: An Array of `User` instances in `ApiSuccessResponse<[User]>` on success, nil on failure
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
