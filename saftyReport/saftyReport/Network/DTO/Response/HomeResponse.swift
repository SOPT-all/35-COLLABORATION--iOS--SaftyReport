//
//  HomeScreenResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - HomeResponse

struct HomeResponse: Codable {
    let status: Int?
    let message: String?
    let data: HomeDataObject?
}

// MARK: - DataObject

struct HomeDataObject: Codable {
    let userID, yearReportCount, monthReportCount, mileage: Int?
    let bannerList: [BannerList]
}

// MARK: - BannerList

struct BannerList: Codable {
    let bannerID: Int?
    let bannerURL: String?
}
