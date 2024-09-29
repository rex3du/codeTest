//
//  MockDataSource.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
class MockImageDataSource: ImageDataSource {

    var result: Result<ImageDataResponse, NetworkError>

    init(result: Result<ImageDataResponse, NetworkError>) {
        self.result = result
    }
    func getImageData() async -> Result<ImageDataResponse, NetworkError> {
        return result
    }
}
