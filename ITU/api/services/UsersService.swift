//
//  UsersService.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

struct UsersService {
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
