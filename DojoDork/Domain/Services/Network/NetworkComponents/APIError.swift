//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

let APIFailedToAuthenticateMessage = "Failed to authenticate"
let APIFailedInactiveUserMessage = "inactive_user"
let APIFailedExpiredSessionMessage = "expired_session"

enum APIError: LocalizedError {
    case noNetwork
    case encodingFailed
    case decodingFailed
    case noResponse
    case badStatusCode(Int)
    case invalidURL
    case missingData
    case loginFailed
    case server(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noNetwork:
            return "No network cound"
        case .encodingFailed:
            return "Failed to encode"
        case .decodingFailed:
            return "Failed to decode"
        case .noResponse:
            return "No response"
        case .badStatusCode(let statusCode):
            return "Bad status code: \(statusCode)"
        case .invalidURL:
            return "Invalid URL"
        case .missingData:
            return "Missing data"
        case .loginFailed:
            return "Unable to login at this time"
        case .server(let errorMessage):
            return "Server error: \(errorMessage)"
        case .unknown:
            return "Unknown API error"
        }
    }
}
