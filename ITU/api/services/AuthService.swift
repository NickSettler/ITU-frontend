//
//  AuthService.swift
//  ITU
//
//  Created by Nikita Moiseev on 26.10.2023.
//

import Foundation
import Alamofire

struct AuthService {

    static func signIn(
        email: String,
        password: String
    ) async -> ApiSuccessResponse<SignInResponse>? {
        do {
            let data = try await NetworkManager.shared.post(
                path: "/auth/login",
                parameters: [
                    "email": email,
                    "password": password
                ]
            )
            let result: ApiSuccessResponse<SignInResponse> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func signUp(
        email: String,
        password: String,
        firstName: String,
        lastName: String
    ) async -> ApiSuccessResponse<SignInResponse>? {
        do {
            _ = try await NetworkManager.shared.post(
                path: "/users",
                parameters: [
                    "email": email,
                    "password": password,
                    "first_name": firstName,
                    "last_name": lastName,
                ]
            )
            
            return await AuthService.signIn(email: email, password: password)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func refresh() async -> ApiSuccessResponse<SignInResponse>? {
        guard let refreshToken = NetworkAPI.refreshToken else {
            return nil
        }
        
        do {
            let data = try await NetworkManager.shared.post(
                path: "/auth/refresh",
                parameters: [
                    "refresh_token":  refreshToken,
                    "mode": "json"
                ]
            )
            let result: ApiSuccessResponse<SignInResponse> = try NetworkAPI.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func conditionalRefresh() async throws {
        guard let token = NetworkAPI.accessToken else {
            throw ApiErrorResponse.noTokenError
        }
        
        if (NetworkAPI.isTokenExpired(token: token)) {
            if let res = await AuthService.refresh() {
                await MainActor.run {
                    NetworkAPI.accessToken = res.data.access_token
                    NetworkAPI.refreshToken = res.data.refresh_token
                }
            } else {
                print("Error during refresh")
            }
        }
    }
}
