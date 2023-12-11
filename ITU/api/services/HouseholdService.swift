//
//  HouseholdService.swift
//  ITU
//
//  Created by Никита Моисеев on 11.12.2023.
//

import Foundation

struct HouseholdService {
    static func create(_ currentUID: String) async -> ApiSuccessResponse<Household>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.post(
                path: "/items/user_household",
                parameters: [
                    "members": [
                        "\(currentUID)"
                    ]
                ]
            )
            
            let result: ApiSuccessResponse<Household> = try NetworkAPI.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func update(_ householdID: Int, parameters: [String: Any]) async -> ApiSuccessResponse<Household>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.patch(
                path: "/items/user_household/\(householdID)",
                parameters: parameters
            )
            
            let result: ApiSuccessResponse<Household> = try NetworkAPI.parseData(data: data)
            
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func delete(_ householdID: Int) async -> Void {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.delete(
                path: "/items/user_household/\(householdID)",
                parameters: nil
            )
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
