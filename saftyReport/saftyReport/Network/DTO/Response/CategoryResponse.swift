//
//  CategoryResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

struct CategoryResponse: Decodable {
    let status: Int
    let message: String
    let data: CategoryDetailList
}

struct CategoryDetailList: Decodable {
    let categoryDetailList: [CategoryDetail]
}

struct CategoryDetail: Decodable, Hashable {
    let categoryId: Int
    let categoryName: String
    let categoryDescription: String
}
