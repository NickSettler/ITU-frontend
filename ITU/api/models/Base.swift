//
//  Base.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import Alamofire

/// API response codes
enum ApiResponseCode : String, Codable {
    case ContainsNullValues = "CONTAINS_NULL_VALUES"
    case ContentTooLarge = "CONTENT_TOO_LARGE"
    case Forbidden = "FORBIDDEN"
    case IllegalAssetTransformation = "ILLEGAL_ASSET_TRANSFORMATION"
    case InvalidCredentials = "INVALID_CREDENTIALS"
    case InvalidForeignKey = "INVALID_FOREIGN_KEY"
    case InvalidIp = "INVALID_IP"
    case InvalidOtp = "INVALID_OTP"
    case InvalidPayload = "INVALID_PAYLOAD"
    case InvalidProvider = "INVALID_PROVIDER"
    case InvalidProviderConfig = "INVALID_PROVIDER_CONFIG"
    case InvalidQuery = "INVALID_QUERY"
    case InvalidToken = "INVALID_TOKEN"
    case MethodNotAllowed = "METHOD_NOT_ALLOWED"
    case NotNullViolation = "NOT_NULL_VIOLATION"
    case RangeNotSatisfiable = "RANGE_NOT_SATISFIABLE"
    case RecordNotUnique = "RECORD_NOT_UNIQUE"
    case RequestsExceeded = "REQUESTS_EXCEEDED"
    case RouteNotFound = "ROUTE_NOT_FOUND"
    case ServiceUnavailable = "SERVICE_UNAVAILABLE"
    case TokenExpired = "TOKEN_EXPIRED"
    case UnexpectedResponse = "UNEXPECTED_RESPONSE"
    case UnprocessableContent = "UNPROCESSABLE_CONTENT"
    case UnsupportedMediaType = "UNSUPPORTED_MEDIA_TYPE"
    case UserSuspended = "USER_SUSPENDED"
    case ValueOutOfRange = "VALUE_OUT_OF_RANGE"
    case ValueTooLong = "VALUE_TOO_LONG"
}

/// API success response structure
struct ApiSuccessResponse<T : Decodable> : Decodable {
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

/// API error response extension structure
struct ApiErrorResponseExtension : Codable {
    let code: ApiResponseCode
    let field: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case field
        case type
    }
}

/// API error response item structure
struct ApiErrorResponseItem : Codable {
    let message: String
    let extensions: ApiErrorResponseExtension?
    
    enum CodingKeys: String, CodingKey {
        case message
        case extensions
    }

    /// Init error response item with message
    /// - Parameter message: error message
    init(message: String) {
        self.message = message
        self.extensions = nil
    }

    /// Init error response item with message and extensions
    /// - Parameters:
    ///   - message: error message
    ///   - extensions: error extensions
    init(message: String, extensions: ApiErrorResponseExtension?) {
        self.message = message
        self.extensions = extensions
    }
}

/// API error response structure
struct ApiErrorResponse : Error, Codable {
    let errors: [ApiErrorResponseItem]
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
    
    static var wrongError: ApiErrorResponse {
        get {
            return .init(errors: [.init(message: "Something went wrong")])
        }
    }
    
    static var noTokenError: ApiErrorResponse {
        get {
            return .init(errors: [.init(message: "No token is present")])
        }
    }
}

/// API result enum to handle success and failure cases
enum ApiResult<Success: Decodable, Error: Decodable>: Decodable {
    case success(Success)
    case failure(Error)
    
    enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
}
