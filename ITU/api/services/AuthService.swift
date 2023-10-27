//
//  AuthService.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import Foundation
import SwiftHttp

struct AuthService : HttpCodablePipelineCollection {
    let client: HttpClient = UrlSessionHttpClient(session: .shared, logLevel: .debug)
    let apiBaseUrl = HttpUrl(scheme: "https", host: "directus.settler.tech")
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping(Result<ApiSuccessResponse<SignInResponse>, ApiErrorResponse>) -> Void
    ) async throws {
        guard let body = try? JSONEncoder().encode([
            "email": email,
            "password": password
        ]) else {
            completion(.failure(.init(error: .init(message: "Error encoding JSON body"))))
            throw ApiErrorResponse(error: .init(message: "NO"))
        }
        
        let response: ApiSuccessResponse<SignInResponse> = try await decodableRequest(
            executor: client.dataTask,
            url: apiBaseUrl.path("auth/login"),
            method: .post,
            body: body,
            headers: [
                "Content-Type": "application/json"
            ]
        )
        
        completion(.success(response))
    }
}
