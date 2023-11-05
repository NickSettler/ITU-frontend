//
//  FoldersService.swift
//  ITU
//
//  Created by Nikita Pasynkov, Elena Marochkina on 05.11.2023.
//

import Foundation

struct FoldersService {
    static func getFolders() async -> ApiSuccessResponse<GetAllUserFoldersResponse>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.get(
                path: "/items/user_locations",
                parameters: nil
            )
            
            let result: ApiSuccessResponse<GetAllUserFoldersResponse> = try NetworkAPI.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func createFolder(name: String) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.post(
                path: "/items/user_locations",
                parameters: [
                    "name": name
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func deleteFolder(id: String) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.delete(
                path: "/items/user_locations/" + id,
                parameters: nil
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func deleteFolders(ids: [String]) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.delete(
                path: "/items/user_locations",
                parameters: [
                    "keys": ids,
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
}
