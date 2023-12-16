//
//  Base.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation
import Alamofire

/// Enum used to represent all possible API response codes
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

/// Struct used to encapsulate API success responses with a specified data structure.
///
/// This struct will decode any decodable data contained in the 'data' field
/// of a success response from the API.
struct ApiSuccessResponse<T : Decodable> : Decodable {
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

/// Structure representing the contextual information in an error response
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

/// Struct used to encapsulate API error response items
struct ApiErrorResponseItem : Codable {
    let message: String
    let extensions: ApiErrorResponseExtension?
    
    enum CodingKeys: String, CodingKey {
        case message
        case extensions
    }

    /// Initializes an error response item with provided error message
    ///
    /// - Parameter message: The error message text
    init(message: String) {
        self.message = message
        self.extensions = nil
    }

    /// Initializes an error response item with provided error message and extensions
    ///
    /// - Parameters:
    ///   - message: The error message text
    ///   - extensions: Error extensions providing additional context to the error
    init(message: String, extensions: ApiErrorResponseExtension?) {
        self.message = message
        self.extensions = extensions
    }
}

/// Struct used to encapsulate API error responses
struct ApiErrorResponse : Error, Codable {
    let errors: [ApiErrorResponseItem]

    enum CodingKeys: String, CodingKey {
        case errors
    }

    /// Returns ApiErrorResponse instance with the error message "Something went wrong"
    static var wrongError: ApiErrorResponse {
        get {
            return .init(errors: [.init(message: "Something went wrong")])
        }
    }

    /// Returns ApiErrorResponse instance with the error message "No token is present"
    static var noTokenError: ApiErrorResponse {
        get {
            return .init(errors: [.init(message: "No token is present")])
        }
    }
}

/// Enum used for handling API result. Can handle both success and failure cases.
///
/// The `ApiResult` enumeration is a type used to represent either a success
/// or a failure. It includes an associated value of a generic type for each case.
///
/// `ApiResult` can be specialized with any type that conforms to `Decodable`
/// protocol for successful and failed API responses.
enum ApiResult<Success: Decodable, Error: Decodable>: Decodable {
    case success(Success)
    case failure(Error)
    
    enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
}
