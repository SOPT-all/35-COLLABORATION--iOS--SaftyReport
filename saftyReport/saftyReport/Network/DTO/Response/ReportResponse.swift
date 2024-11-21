//
//  ReportResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - ReportResponse

struct ReportResponse: Codable {
    let status: Int?
    let message: String?
    let data: ReportDataObject?
}

// MARK: - ReportDataObject

struct ReportDataObject: Codable {
    let reportID: Int?
    let photoList: [ReportPhotoList]?
    let address, content, phoneNumber, category: String?
}

// MARK: - ReportPhotoList

struct ReportPhotoList: Codable {
    let photoID: Int?
    let photoURL: String?
}
