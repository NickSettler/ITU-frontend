//
//  Base.swift
//  ITU
//
//  Created by Никита Моисеев on 25.10.2023.
//

import Foundation

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

struct ApiSuccessResponse<T : Codable> : Codable {
    let data: T
}

struct ApiErrorResponseExtension : Codable {
    let code: ApiResponseCode
    let field: String?
    let type: String?
}

struct ApiErrorResponseItem : Codable {
    let message: String
}

struct ApiErrorResponse : Error {
    let error: ApiErrorResponseItem
}