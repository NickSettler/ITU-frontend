//
//  DrugsService.swift
//  ITU
//
//  Created by Elena Marochkina on 27.10.2023.
//

import SwiftUI
import Foundation
import Alamofire
import JWTDecode

struct DrugsService {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private static var accessToken: String?
    
    static let session = Session.default
    
    static func getAllUserDrugs() async -> ApiSuccessResponse<GetAllUsersDrugsResponse>? {
        try? await AuthService.conditionalRefresh()
        
        do {
            let data = try await NetworkManager.shared.get(
                path: "/items/user_drugs?fields=*.*.*",
                parameters: nil
            )
            let result: ApiSuccessResponse<GetAllUsersDrugsResponse> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
