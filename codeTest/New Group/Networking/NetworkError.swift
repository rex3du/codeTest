//
//  NetworkError.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidServerResponse
    case invalidURL
    case unauthorized
    case requestFailed(String)
    case decodingFailed(String)

    public var errorDescription: String? {
        switch self {
            case .invalidServerResponse:
                return "The server returned an invalid response."
            case .invalidURL:
                return "URL string is malformed."
            case .unauthorized:
                return "Oops! Something is wrong. Unauthorized error"
            case let .requestFailed(message):
                return "Oops! Something is wrong. Request Failed: \(message)"
            case .decodingFailed:
                return "Oops! Something is wrong. decodingFailed Error"
        }
    }
}
