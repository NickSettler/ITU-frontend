//
//  FoldersService.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

struct FoldersService {
    /// Get all user folders
    ///
    /// - Returns: A GetAllUserFoldersResponse with all user folders
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

    /// Create folder function
    ///
    /// - Parameters:
    ///     - name: Folder name
    ///     - icon: Folder icon
    ///
    /// - Returns: true if created, false otherwise
    static func createFolder(name: String, icon: String) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.post(
                path: "/items/user_locations",
                parameters: [
                    "name": name,
                    "icon": icon
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Update folder function
    ///
    /// - Parameters:
    ///     - id: Folder ID to update
    ///     - name: Folder name
    ///     - icon: Folder icon
    ///
    /// - Returns: true if updated, false otherwise
    static func updateFolder(id: String, name: String, icon: String) async -> Bool {
        try? await AuthService.conditionalRefresh()

        do {
            _ = try await NetworkManager.shared.patch(
                path: "/items/user_locations/" + id,
                parameters: [
                    "name": name,
                    "icon": icon
                ]
            )

            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Delete folder function
    ///
    /// - Parameters:
    ///     - id: Folder ID to delete
    ///
    /// - Returns: true if deleted, false otherwise
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

    /// Delete folders function
    ///
    /// - Parameters:
    ///     - ids: Folder IDs to delete
    ///
    /// - Returns: true if deleted, false otherwise
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
