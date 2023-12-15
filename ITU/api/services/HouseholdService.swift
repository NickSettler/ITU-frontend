//
//  HouseholdService.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

struct HouseholdService {
    /// Create household
    ///
    /// - Parameters:
    ///     - currentUID: User id
    ///
    /// - Returns: A Household
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

    /// Update household
    ///
    /// - Parameters:
    ///     - householdID: Household id
    ///     - parameters: Household parameters
    ///
    /// - Returns: A Household
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

    /// Delete household
    ///
    /// - Parameters:
    ///     - householdID: Household id
    ///
    /// - Returns: Void
    static func delete(_ householdID: Int) async -> Void {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.delete(
                path: "/items/user_household/\(householdID)",
                parameters: nil
            )
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
