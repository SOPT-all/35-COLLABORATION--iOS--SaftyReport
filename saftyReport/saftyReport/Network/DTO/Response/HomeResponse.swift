//
//  HomeScreenResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import UIKit

import Alamofire

// MARK: - HomeScreenResponse

struct HomeScreenResponse: Codable {
    let status: Int?
    let message: String?
    let data: DataObject?
}

// MARK: - DataObject

struct DataObject: Codable {
    let userID, yearReportCount, monthReportCount, mileage: Int?
    let bannerList: [BannerList]
}

// MARK: - BannerList

struct BannerList: Codable {
    let bannerID: Int?
    let bannerURL: String?
}

// MARK: - FailResponse

struct FailResponse: Codable {
    let status: Int?
    let message: String?
}
