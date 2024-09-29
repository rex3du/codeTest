//
//  ImageData.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation

struct ImageData: Codable,Hashable,Equatable {
    let name: String
    let tags: [String]
    let width: Int
    let height: Int
    
    var isPortrait: Bool {
        return height > width
    }

    var isLandscape: Bool {
        return width > height
    }
}
