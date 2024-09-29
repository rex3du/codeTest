//
//  SearchImageViewModel.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
@MainActor
class SearchImageViewModel: ObservableObject {
    
    private let dataSource: ImageDataSource
    
    @Published var searchResults : [ImageData]
    @Published var imagePath: String = ""
    @Published var searchText: String = ""
    @Published var state: ViewState = .initial

    init(datasource: ImageDataSource) {
        self.dataSource = datasource
        self.searchResults = []
    }

    func searchImage(searchText: String) async {
        state = .loading
        
        let result = await dataSource.getImageData()
        switch result {
        case .success(let response):
            self.imagePath = response.imagePath
            self.searchResults = filterImage(input:searchText, results: response.images)
            self.state = .success
        case .failure(let failure):
            self.state = .error(failure.localizedDescription)
        }
    }
    
    func filterImage(input: String, results: [ImageData]) -> [ImageData] {
        let keywords = input.lowercased().split(separator: " ").map { String($0) }
        
        let colors = keywords.filter { !$0.starts(with: "is:") }
        let orientations = keywords.filter { $0.starts(with: "is:") }
        
        if !colors.isEmpty || !orientations.isEmpty {
              return results.filter { image in
                  let colorMatch = colors.allSatisfy { image.tags.contains($0) }
                  let orientationMatch = orientations.allSatisfy { filter in
                      switch filter {
                      case "is:portrait":
                          return image.isPortrait
                      case "is:landscape":
                          return image.isLandscape
                      default:
                          return false
                      }
                  }
                  return colorMatch && orientationMatch
              }
          }
          return results
    }
}

enum ViewState: Equatable {
    case initial, loading, error(String), success, empty
}
