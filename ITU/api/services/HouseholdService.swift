//
//  HouseholdService.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// `HouseholdService` is a struct that contains all the Household related network calls
struct HouseholdService {

    /// Creates a new household for a user.
    ///
    /// - Parameters:
    ///     - currentUID: The User ID as string.
    ///
    /// - Returns: An instance of `ApiSuccessResponse<Household>` type
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

    /// Updates an existing household.
    ///
    /// - Parameters:
    ///     - householdID: The Household ID as integer.
    ///     - parameters: The parameters to update in the household as a dictionary.
    ///
    /// - Returns: An instance of `ApiSuccessResponse<Household>` type
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

    /// Deletes a household based on its Id.
    ///
    /// - Parameters:
    ///     - householdID: The Household ID to delete as integer.
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
