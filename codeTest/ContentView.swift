//
//  ContentView.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @StateObject var viewModel: SearchImageViewModel = SearchImageViewModel(datasource: ImageDataSourceImpl(requestManager: DefaultRequestManager(networkManager: DefaultNetworkManager())))
    
    var body: some View {
        VStack {
            
            SearchBar(text: $viewModel.searchText)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchResults, id:\.self) { image in
                        VStack (alignment: .leading) {
                            if let imageURL = URL(string: viewModel.imagePath + image.name) {
                                KFImage(imageURL)
                                    .waitForCache()
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            VStack (alignment: .leading) {
                                HStack (alignment: .center,spacing: 8) {
                                    Text("Name:")
                                        .fontWeight(.bold)
                                    Text(image.name)
                                }
                                HStack (alignment: .center,spacing: 8) {
                                    Text("Tags:")
                                        .fontWeight(.bold)

                                    Text(image.tags.joined(separator: ","))
                                }
                            }
                            .padding(.vertical,6)
                        }
                        Divider()
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.searchImage()
            }
        }
    }
}

#Preview {
    ContentView()
}
