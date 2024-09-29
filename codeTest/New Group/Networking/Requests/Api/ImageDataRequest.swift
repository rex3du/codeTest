//
//  DataRequest.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation

enum ImageDataRequest: RequestProtocol {
    case getDataJSON

    var path: String {
        switch self {
        case .getDataJSON:
            return "/data.json"
        }
    }

    var requestType: RequestType {
        switch self {
        case .getDataJSON:
            return .GET
        }
    }
}
