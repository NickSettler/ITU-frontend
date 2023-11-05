//
//  AuthService.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import Foundation
import SwiftHttp


import Alamofire

struct AuthService {
    let session = Session.default
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping(Result<ApiSuccessResponse<SignInResponse>, ApiErrorResponse>) -> Void
    ) async {
        let parameters: [String: String] = [
            "email": email,
            "password": password,
        ]
        
        session.request(
            "https://directus.settler.tech/auth/login",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of: ApiSuccessResponse<SignInResponse>.self) { r in
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
    
    func signUp(
        email: String,
        password: String,
        firstName: String,
        lastName: String
    ) async throws {
        
    }
}
