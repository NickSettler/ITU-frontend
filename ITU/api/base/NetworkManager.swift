//
//  NetworkManager.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI
import Foundation
import Alamofire

/// This is the base URL for the API.
private let API_BASE_URL = "https://directus.settler.tech"

/// Network Manager using Alamofire library
///
/// - Author: Nikita Moiseev
///
/// Manages network calls with various HTTP methods. Main methods encapsulated here are GET, POST, PATCH, DELETE.
actor NetworkManager: GlobalActor {
    /// Stores the access token of the user session
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    
    /// Singleton instance of the NetworkManager
    static let shared = NetworkManager()
    private init() {}
    
    /// Max waiting time for each request
    private let maxWaitTime = 15.0
    /// Headers that common to all requests
    var commonHeaders: HTTPHeaders = [
    ]

    /// Send POST request
    ///
    /// - Parameters:
    ///   - path: API endpoint to send request to
    ///   - parameters: The parameters included in the request body
    ///
    /// - Throws: An error if the request fails
    ///
    /// - Returns: The server response data
    ///
    func post(path: String, parameters: Parameters?) async throws -> Data {
        if let token = self.accessToken {
            if (!NetworkAPI.isTokenExpired(token: token)) {
                commonHeaders.add(name: "Authorization", value: "Bearer " + token)
            }
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                API_BASE_URL + path,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .validate()
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    /// Send PATCH request
    ///
    /// - Parameters:
    ///   - path: API endpoint to send request to
    ///   - parameters: The parameters included in the request body
    ///
    /// - Throws: An error if the request fails
    ///
    /// - Returns: The server response data
    ///
    func patch(path: String, parameters: Parameters?) async throws -> Data {
        if let token = self.accessToken {
            if !NetworkAPI.isTokenExpired(token: token) {
                commonHeaders.add(name: "Authorization", value: "Bearer " + token)
            }
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                API_BASE_URL + path,
                method: .patch,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    /// Send DELETE request
    ///
    /// - Parameters:
    ///   - path: API endpoint to send request to
    ///   - parameters: The parameters included in the request body
    ///
    /// - Throws: An error if the request fails
    ///
    /// - Returns: The server response data
    ///
    func delete(path: String, parameters: Parameters?) async throws -> Data {
        if let token = self.accessToken {
            if (!NetworkAPI.isTokenExpired(token: token)) {
                commonHeaders.add(name: "Authorization", value: "Bearer " + token)
            }
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                API_BASE_URL + path,
                method: .delete,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .validate()
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    /// Send GET request
    ///
    /// - Parameters:
    ///   - path: API endpoint to send request to
    ///   - parameters: The parameters to include in the query string
    ///
    /// - Throws: An error if the request fails
    ///
    /// - Returns: The server response data
    ///
    func get(path: String, parameters: Parameters?) async throws -> Data {
        if let token = self.accessToken {
            commonHeaders.add(name: "Authorization", value: "Bearer " + token)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                API_BASE_URL + path,
                parameters: parameters,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    /// Handle error from request
    ///
    /// - Parameters:
    ///   - error: The error occurred during the request
    ///
    /// - Returns: Handled error with an updated error message, if needed
    ///
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
