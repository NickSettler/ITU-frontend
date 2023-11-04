//
//  AuthService.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import Foundation
import SwiftHttp

//struct AuthService : HttpCodablePipelineCollection {
//    let client: HttpClient = UrlSessionHttpClient(session: .shared, logLevel: .debug)
//    let apiBaseUrl = HttpUrl(scheme: "https", host: "directus.settler.tech")
//    
//    func signIn(
//        email: String,
//        password: String,
//        completion: @escaping(Result<ApiSuccessResponse<SignInResponse>, ApiErrorResponse>) -> Void
//    ) async throws {
//        guard let body = try? JSONEncoder().encode([
//            "email": email,
//            "password": password
//        ]) else {
//            completion(.failure(.init(errors: [.init(message: "Error encoding JSON body")])))
//            return
//        }
//        
//        do {
//            let response: ApiSuccessResponse<SignInResponse> = try await decodableRequest(
//                executor: client.dataTask,
//                url: apiBaseUrl.path("auth/login"),
//                method: .post,
//                body: body,
//                headers: [
//                    "Content-Type": "application/json"
//                ]
//            )
//            
//            completion(.success(response))
//        } catch {
//            completion(.failure(error as! ApiErrorResponse))
//            print(error)
//        }
//    }
//}


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
