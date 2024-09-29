//
//  DataParser.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
import OSLog

protocol DataParser {
    func parse<T: Decodable>(data: Data) throws -> T
}

class DefaultDataParser: DataParser {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        do {
            // Comment out when you need to debug response JSON
            //Logger.networking.info("Parse Data: \(String(describing: String(data: data, encoding: .utf8)))")
            return try jsonDecoder.decode(T.self, from: data)
        } catch let decodeError as DecodingError {
            //Logger.networking.error("DataParser:  \(decodeError)")
            throw NetworkError.decodingFailed("Decoding failed: \(decodeError)")
        } catch {
            throw NetworkError.requestFailed("Parser Error")
        }
    }
}
