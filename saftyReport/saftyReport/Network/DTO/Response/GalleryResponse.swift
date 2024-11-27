//
//  GalleryResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - GalleryResponse

struct GalleryResponse: Codable {
    let status: Int?
    let message: String?
    let data: GalleryData?
}

// MARK: - GalleryData

struct GalleryData: Codable {
    let photoList: [GalleryPhotoList]?
}

// MARK: - GalleryPhotoList

struct GalleryPhotoList: Codable {
    let photoID: Int?
    let photoURL, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case photoID = "photoId"
        case photoURL = "photoUrl"
        case createdAt
    }
}
