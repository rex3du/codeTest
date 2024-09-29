//
//  BaseResponseModel.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
struct BaseResponseModel<T: Decodable>: Decodable {
    let imagePath: String
    let images: T
}
