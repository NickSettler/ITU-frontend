//
//  AuthService.swift
//  ITU
//
//  Created by Elena Marochkina,Nikita Pasynkov
//

import Foundation
import Alamofire

/// `AuthService` is a struct that contains all the authentication-related network calls
struct AuthService {
    /// Sign In service call that posts user credentials to `/auth/login` and returns `SignInResponse`
    ///
    /// - Author: Elena Marochkina
    ///
    /// - Parameters:
    ///   - email: User's email as string.
    ///   - password: User's password as string.
    /// - Returns: An instance of `ApiSuccessResponse<SignInResponse>` type
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

    /// Sign Up service call that posts a new user's details to `/users` and returns `SignInResponse`
    ///
    /// - Author: Nikita Pasynkov
    ///
    /// - Parameters:
    ///   - email: New User's email as string.
    ///   - password: New User's password as string.
    ///   - firstName: New User's firstName as string.
    ///   - lastName: New User's lastName as string.
    /// - Returns: An instance of `ApiSuccessResponse<SignInResponse>` type
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
    
    /// Refresh token service call that posts to `/auth/refresh` with refresh_token
    ///
    /// - Author: Elena Marochkina
    ///
    /// - Returns: An instance of `ApiSuccessResponse<SignInResponse>` type
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
    
    /// Conditional Refresh service call that attempts to refresh user access token
    /// Author: Elena Marochkina
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
