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

    func searchImage(color: String) async {
        state = .loading
        
        let result = await dataSource.getImageData()
        switch result {
        case .success(let response):
            self.imagePath = response.imagePath
            self.searchResults = filterColor(color: color, results: response.images)
            self.state = .success
        case .failure(let failure):
            self.state = .error(failure.localizedDescription)
        }
    }
    
    func filterColor(color: String, results: [ImageData]) -> [ImageData] {
        let colors = color.lowercased().split(separator: " ").map { String($0) }
        if !colors.isEmpty {
            return results.filter { image in
                colors.allSatisfy { image.tags.contains($0) }
            }
        }
        return results
    }
}

enum ViewState: Equatable {
    case initial, loading, error(String), success, empty
}
