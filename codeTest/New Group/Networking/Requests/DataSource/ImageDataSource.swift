//
//  ImageDataSource.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation

typealias ImageDataResponse = BaseResponseModel<[ImageData]>

protocol ImageDataSource {
    func getImageData() async -> Result<ImageDataResponse, NetworkError>
}

class ImageDataSourceImpl: ImageDataSource {
       
    private let requestManager: RequestManager
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getImageData() async -> Result<ImageDataResponse, NetworkError> {
        do {
            let request = ImageDataRequest.getDataJSON
            let response: ImageDataResponse = try await requestManager.makeRequest(with: request)
            return .success(response)
        } catch {
            return .failure(error.toNetworkError)
        }
    }
}
