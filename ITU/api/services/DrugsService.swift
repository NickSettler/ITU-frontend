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
    
    static func getAllUserDrugs(completion: @escaping(Result<ApiSuccessResponse<GetAllUsersDrugsResponse>, ApiErrorResponse>) -> Void) async {
        guard let token = accessToken else {
            completion(.failure(.noTokenError))
            return
        }
        
        guard let decodedToken = try? decode(jwt: token) else {
            completion(.failure(.noTokenError))
            return
        }
        
        guard let userID = decodedToken.body["id"] else {
            completion(.failure(.noTokenError))
            return
        }
        
        session.request(
            "https://directus.settler.tech/items/user_drugs",
            method: .get,
            encoding: JSONEncoding.default,
            headers: [
                "Authorization": "Bearer " + token
            ]
        )
        .validate()
        .responseDecodable(of: ApiSuccessResponse<GetAllUsersDrugsResponse>.self) { r in
            switch(r.result) {
            case let .success(data):
                completion(.success(data))
                break
            case .failure(_):
                guard let data = r.data else {
                    completion(.failure(.wrongError))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let errorObject = try decoder.decode(ApiErrorResponse.self, from: data)
                    completion(.failure(errorObject))
                } catch {
                    completion(.failure(.wrongError))
                }
                break
            }
        }
    }
}
