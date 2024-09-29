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

    func searchImage() async {
        state = .loading
        
        let result = await dataSource.getImageData()
        switch result {
        case .success(let response):
            self.imagePath = response.imagePath
            self.searchResults = response.images
            self.state = .success
        case .failure(let failure):
            self.state = .error(failure.localizedDescription)
        }
    }
}

enum ViewState: Equatable {
    case initial, loading, error(String), success, empty
}
