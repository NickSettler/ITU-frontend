//
//  FoldersService.swift
//  ITU
//
//  Created by Nikita Pasynkov on 05.11.2023.
//

import Foundation

struct FoldersService {
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
}
