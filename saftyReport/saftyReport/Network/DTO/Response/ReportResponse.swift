//
//  ReportResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - Request Models
struct ReportRequest: Encodable {
    let photoList: [PhotoRequest]
    let address: String
    let content: String
    let phoneNumber: String
    let category: String
}

struct PhotoRequest: Encodable {
    let photoId: Int
    let photoUrl: String
}

// MARK: - Response Models
struct ReportResponse: Codable {
    let status: Int?
    let message: String?
    let data: ReportData?
}

struct ReportData: Codable {
    let reportId: Int?
    let photoList: [PhotoResponse]?
    let address: String?
    let content: String?
    let phoneNumber: String?
    let category: String?
    
    enum CodingKeys: String, CodingKey {
        case reportId = "reportID"
        case photoList
        case address
        case content
        case phoneNumber
        case category
    }
}

struct PhotoResponse: Codable {
    let photoId: Int?
    let photoUrl: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case photoId = "photoID"
        case photoUrl = "photoURL"
        case createdAt
    }
}
