//
//  FoldersService.swift
//  ITU
//
//  Created by Elena Marochkina
//

import Foundation

/// `FoldersService` is a struct that contains all the Folder related network calls
struct FoldersService {

    /// Gets all user folders.
    ///
    /// - Returns: An instance of `ApiSuccessResponse<GetAllUserFoldersResponse>` type
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

    /// Creates a new folder for a user.
    ///
    /// - Parameters:
    ///     - name: Name of the new folder
    ///     - icon: Icon of the new folder
    ///     - description: Description of the new folder
    ///     - isPrivate: Boolean flag indicating if the folder is private or not
    ///
    /// - Returns: True if created successfully, false otherwise
    static func createFolder(name: String, icon: String, description: String, isPrivate: Bool) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.post(
                path: "/items/user_locations",
                parameters: [
                    "name": name,
                    "icon": icon,
                    "description": description,
                    "private": isPrivate
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Updates an existing folder.
    ///
    /// - Parameters:
    ///     - id: Folder ID to update by
    ///     - name: New name of the folder
    ///     - icon: New icon of the folder
    ///     - description: New description of the folder
    ///     - isPrivate: New value for the boolean flag indicating if the folder is private or not
    ///
    /// - Returns: True if updated successfully, false otherwise
    static func updateFolder(id: String, name: String, icon: String, description: String, isPrivate: Bool) async -> Bool {
        try? await AuthService.conditionalRefresh()

        do {
            _ = try await NetworkManager.shared.patch(
                path: "/items/user_locations/" + id,
                parameters: [
                    "name": name,
                    "icon": icon,
                    "description": description,
                    "private": isPrivate
                ]
            )

            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Deletes a folder based on its Id.
    ///
    /// - Parameters:
    ///     - id: Folder ID to delete
    ///
    /// - Returns: True if deleted successfully, false otherwise
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

    /// Deletes multiple folders based on their Ids.
    ///
    /// - Parameters:
    ///     - ids: Array of Folder IDs to delete
    ///
    /// - Returns: True if all folders are deleted successfully, false otherwise
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
