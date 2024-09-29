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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }
    
    func testSearchImage_Success() async {
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683),
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image5",
                      tags: [
                          "blue",
                          "yellow",
                          "green",
                          "black"
                      ], width: 1024, height: 683)
        ]
        
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"

        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "")
        let state = await viewModel.state
        XCTAssertEqual(state, .success)
        
        let imagePath = await viewModel.imagePath
        XCTAssertEqual(imagePath, expectedImagePath)
        
        let searchResults = await viewModel.searchResults
        XCTAssertEqual(searchResults, sampleData)
    }
    
    func testSearchImage_Failure() async {
        mockDataSource = MockImageDataSource(result: .failure(NetworkError.requestFailed("Test")))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "")
        
        let state = await viewModel.state
        XCTAssertEqual(state, .error("Oops! Something is wrong. Request Failed: Test"))
      
        let imagePath = await viewModel.imagePath
        XCTAssertEqual(imagePath, "")
        
        let searchResults = await viewModel.searchResults
        XCTAssertEqual(searchResults, [])
    }
    
    func testFilterColor_WithAllMatchingConditions() async {
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683),
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image5",
                      tags: [
                          "blue",
                          "yellow",
                          "green",
                          "black"
                      ], width: 1024, height: 683)
        ]
        
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"

        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "pink blue is:landscape")
        let searchResults = await viewModel.searchResults

        let expectedResults = [
            
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683)
        ]
        XCTAssertEqual(searchResults, expectedResults)
    }
    
    func testFilterColor_WithColorMatchingConditions() async {
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683),
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image5",
                      tags: [
                          "blue",
                          "yellow",
                          "green",
                          "black"
                      ], width: 1024, height: 683)
        ]
        
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"

        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "grey")
        let searchResults = await viewModel.searchResults

        let expectedResults = [
            
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
        ]
        XCTAssertEqual(searchResults, expectedResults)
    }
    
    func testFilterColor_WithOritentionLandscapeMatchingConditions() async {
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683),
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image5",
                      tags: [
                          "blue",
                          "yellow",
                          "green",
                          "black"
                      ], width: 1024, height: 683)
        ]
        
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"

        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "is:landscape")
        let searchResults = await viewModel.searchResults

        let expectedResults = sampleData
        
        XCTAssertEqual(searchResults, expectedResults)
    }
    
    func testFilterColor_WithOritentionPortraitMatchingConditions() async {
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683),
            ImageData(name: "Image4",
                      tags: [
                          "red",
                          "brown",
                          "white",
                          "blue",
                          "green",
                          "yellow",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image5",
                      tags: [
                          "blue",
                          "yellow",
                          "green",
                          "black"
                      ], width: 300, height: 683)
        ]
        
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"

        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "is:portrait")
        let searchResults = await viewModel.searchResults

        let expectedResults = [ ImageData(name: "Image5",
                                          tags: [
                                              "blue",
                                              "yellow",
                                              "green",
                                              "black"
                                          ], width: 300, height: 683)]
        
        XCTAssertEqual(searchResults, expectedResults)
    }
    
    func testFilterColor_WithNoMatching() async {
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"
        
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683)
        ]
        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "black pink")

        let searchResults = await viewModel.searchResults

        XCTAssertEqual(searchResults, [])
    }
    
    func testFilterColor_WithEmptySearchText() async {
        let expectedImagePath = "http://frontendtest.jobs.fastmail.com.user.fm/images/"
        
        let sampleData = [
            ImageData(name: "Image1",
                      tags: [
                          "pink",
                          "purple"
                      ], width: 1024, height: 683),
            ImageData(name: "Image2",
                      tags: [
                          "green",
                          "brown",
                          "yellow",
                          "red",
                          "grey"
                      ], width: 1024, height: 683),
            ImageData(name: "Image3",
                      tags: [
                          "pink",
                          "blue"
                      ], width: 1024, height: 683)
        ]
        let response = ImageDataResponse(imagePath: expectedImagePath, images: sampleData)
        mockDataSource = MockImageDataSource(result: .success(response))
        viewModel = await SearchImageViewModel(datasource: mockDataSource)

        await viewModel.searchImage(searchText: "")

        let searchResults = await viewModel.searchResults

        XCTAssertEqual(searchResults, sampleData)
    }
}
