//
//  RequestProtocol.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
import OSLog

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var access_token: String { get }
}

// MARK: - Default RequestProtocol

extension RequestProtocol {
    var host: String {
        return APIConstants.apiHost
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    var access_token: String {
        return ""
    }

    func joinIntsByComma(_ numbers: [Int]) -> String {
        return numbers.map { String($0) }.joined(separator: ",")
    }

    func request() throws -> URLRequest {
        guard var components = URLComponents(string: "http://" + host + path) else {
            throw NetworkError.invalidURL
        }

        var queryParamsList: [URLQueryItem] = []

        if !urlParams.isEmpty {
            queryParamsList.append(contentsOf: urlParams.map { URLQueryItem(name: $0, value: $1) })
            components.queryItems = queryParamsList
        }

        guard let url = components.url else {
            //Logger.networking.info("")
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            //Logger.networking.info("[BODY DATA] \(params)")
        }

       // Logger.networking.info("🚀 [REQUEST] [\(requestType.rawValue)] \(urlRequest, privacy: .private)")

        return urlRequest
    }
}
