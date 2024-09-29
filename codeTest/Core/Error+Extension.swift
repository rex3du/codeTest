//
//  Error+Extension.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
extension Error {
    var toNetworkError: NetworkError {
        return NetworkError.requestFailed(self.localizedDescription)
    }
}
