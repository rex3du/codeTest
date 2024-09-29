//
//  codeTestTests.swift
//  codeTestTests
//
//  Created by Rex Du on 30/9/2024.
//

@testable import codeTest
import XCTest

final class codeTestTests: XCTestCase {
    var viewModel: SearchImageViewModel!
    var mockDataSource: MockImageDataSource!
    var networkManager: NetworkManager!

    func testSearchImage_Success() async {
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"
        let expectedImages = [ImageData(name: "norway-1.jpg", tags: [
            "pink",
            "purple"
        ], width: 1024, height: 683),
        ImageData(name: "norway-2.jpg", tags: [
            "green",
            "brown",
            "yellow",
            "red",
            "grey"
        ], width: 1024, height: 683)]
        let response = ImageDataResponse(imagePath: expectedImagePath, images: expectedImages)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage()
        let state = await viewModel.state
        XCTAssertEqual(state, .success)
        
        let imagePath = await viewModel.imagePath
        XCTAssertEqual(imagePath, expectedImagePath)
        
        let searchResults = await viewModel.searchResults
        XCTAssertEqual(searchResults, expectedImages)
    }
    
    func testSearchImage_Failure() async {
        mockDataSource = MockImageDataSource(result: .failure(NetworkError.requestFailed("Test")))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage()
        
        let state = await viewModel.state
        XCTAssertEqual(state, .error("Oops! Something is wrong. Request Failed: Test"))
      
        let imagePath = await viewModel.imagePath
        XCTAssertEqual(imagePath, "")
        
        let searchResults = await viewModel.searchResults
        XCTAssertEqual(searchResults, [])
    }
    
}
