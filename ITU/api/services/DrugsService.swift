//
//  DrugsService.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation
import Alamofire
import JWTDecode

struct DrugsService {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private static var accessToken: String?
    
    /// Get all user drugs function
    ///
    /// - Returns: Array of user drugs, they has access to
    static func getAllUserDrugs() async -> ApiSuccessResponse<GetAllUsersDrugsResponse>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.get(
                path: "/items/user_drugs?fields=*.*",
                parameters: nil
            )
            let result: ApiSuccessResponse<GetAllUsersDrugsResponse> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    /// Create new drug function
    ///
    /// - Parameters:
    ///     - createdDrug: Drug entity to be created
    ///
    /// - Returns: true if created, false otherwise
    static func createDrug(createdDrug: Drug) async -> Bool {
        try? await AuthService.conditionalRefresh()

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: createdDrug.expiration_date)
        
        guard let createdDrugForm = createdDrug.form else {
            return false
        }

        do {
            _ = try await NetworkManager.shared.post(
                path: "/items/user_drugs",
                parameters: [
                    "name": createdDrug.name,
                    "strength": createdDrug.strength ?? "",
                    "form": createdDrugForm.form,
                    "count": createdDrug.count,
                    "expiration_date": formattedDate
                ]
            )

            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    /// Update existing drug function
    ///
    /// - Parameters:
    ///     - id: Drug ID to update by
    ///     - createdDrug: Drug entity to be updated
    ///
    /// - Returns: updated drug entity
    static func updateDrug(id: Int, updatedDrug: Drug) async -> ApiSuccessResponse<Drug>? {
        try? await AuthService.conditionalRefresh()

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: updatedDrug.expiration_date)
        
        guard let drugForm = updatedDrug.form else {
            return nil
        }

        do {
            let data = try await NetworkManager.shared.patch(
                path: "/items/user_drugs/\(id)",
                parameters: [
                    "name": updatedDrug.name,
                    "strength": updatedDrug.strength ?? "",
                    "form": drugForm.form,
                    "count": updatedDrug.count,
                    "expiration_date": formattedDate
                ]
            )
            
            let result: ApiSuccessResponse<Drug> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    /// Move drug to another folder
    ///
    /// - Parameters:
    ///     - id: Drug ID to move
    ///     - folderID: Folder ID to move to
    ///
    /// - Returns: true if moved, false otherwise
    static func moveDrug(_ id: Int, folderID: String?) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.patch(
                path: "/items/user_drugs/\(id)",
                parameters: [
                    "location": folderID
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Delete drug function
    ///
    /// - Parameters:
    ///     - id: Drug ID to delete
    ///
    /// - Returns: true if deleted, false otherwise
    static func deleteDrug(_ id: Int) async -> Bool {
        try? await AuthService.conditionalRefresh()
        
        do {
            _ = try await NetworkManager.shared.patch(
                path: "/items/user_drugs/\(id)",
                parameters: [
                    "status": "DELETED"
                ]
            )
            
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }

    /// Get user drug by id function
    ///
    /// - Parameters:
    ///     - id: Drug ID to get by
    ///
    /// - Returns: Drug entity
    static func getUserDrug(_ id: Int) async -> ApiSuccessResponse<GetUsersDrugResponse>? {
        try? await AuthService.conditionalRefresh()

        do {
            let data = try await NetworkManager.shared.get(
                path: "/items/user_drugs/\(id)?fields=*.*",
                parameters: nil
            )
            let result: ApiSuccessResponse<GetUsersDrugResponse> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
