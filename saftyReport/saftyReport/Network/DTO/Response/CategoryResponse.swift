//
//  CategoryResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - CategoryResponse

struct CategoryResponse: Codable {
    let status: Int?
    let message: String?
    let data: CategoryDataObject?
}

// MARK: - DataClass

struct CategoryDataObject: Codable {
    let categoryDetailList: [CategoryDetailList]?
}

// MARK: - CategoryDetailList

struct CategoryDetailList: Codable {
    let categoryID: Int?
    let categoryName, categoryDescription: String?
}
