//
//  DrugsService.swift
//  ITU
//
//  Created by Nikita Pasynkov, Elena Marochkina on 27.10.2023.
//

import SwiftUI
import Foundation
import Alamofire
import JWTDecode

struct DrugsService {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private static var accessToken: String?
    
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
