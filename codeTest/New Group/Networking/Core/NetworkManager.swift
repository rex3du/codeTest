//
//  NetworkManager.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
import OSLog

/// The network manager protocol.
/// It is responsible for making network requests.
protocol NetworkManager {
    func makeRequest(with requestData: RequestProtocol) async throws -> Data
}

class DefaultNetworkManager: NetworkManager {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    /// Makes a network request.
    ///
    /// - Parameter requestData: The request data
    /// - Returns: The response data
    /// - Throws: An error if the request fails.
    /// - Note: This method is asynchronous.
    /// - Important: The request data should conform to `RequestProtocol`.
    /// - SeeAlso: `RequestProtocol`
    func makeRequest(with requestData: RequestProtocol) async throws -> Data {
        let request = try requestData.request()
        var responseStatusCode: Int?
        do {
            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidServerResponse
            }
            responseStatusCode = httpResponse.statusCode

            return data
    
        }
        catch let decodeError as DecodingError {
            throw NetworkError.decodingFailed("Decoding failed: \(decodeError)")
        }
        catch {
            logError(responseStatusCode, request, error)
            throw NetworkError.requestFailed("request failed: \(error)")
        }
    }

    private func logSuccess(_ request: URLRequest, _ httpResponse: HTTPURLResponse) {
        print("""
        ✅ [\(200)] [\(request.httpMethod ?? "")] \
        \(request)
        """)
    }

    private func logError(_ responseStatusCode: Int?, _ request: URLRequest, _ error: Error) {
        print("""
        🛑 [Error] [\(responseStatusCode ?? 0)] [\(request.httpMethod ?? "")] \
        \(request)
        Error Type: \(error.localizedDescription)
        """)
    }

}
