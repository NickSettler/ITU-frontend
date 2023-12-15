//
//  NetworkManager.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI
import Foundation
import Alamofire

private let API_BASE_URL = "https://directus.settler.tech"

actor NetworkManager: GlobalActor {
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) private var accessToken: String?
    
    static let shared = NetworkManager()
    private init() {}
    
    private let maxWaitTime = 15.0
    var commonHeaders: HTTPHeaders = [
    ]

    /// Send POST request
    /// - Parameters:
    ///   - path: path to send request to
    ///   - parameters: parameters to send
    /// - Throws: error if request fails
    /// - Returns: response data
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
    /// - Parameters:
    ///   - path: path to send request to
    ///   - parameters: parameters to send
    /// - Throws: error if request fails
    /// - Returns: response data
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
    /// - Parameters:
    ///   - path: path to send request to
    ///   - parameters: parameters to send
    /// - Throws: error if request fails
    /// - Returns: response data
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
    /// - Parameters:
    ///   - path: path to send request to
    ///   - parameters: parameters to send
    /// - Throws: error if request fails
    /// - Returns: response data
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
    /// - Parameter error: error to handle
    /// - Returns: handled error
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
