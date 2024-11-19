//
//  GalleryItem.swift
//  saftyReport
//
//  Created by OneTen on 11/18/24.
//

import UIKit

struct GalleryItem: Hashable {
    let id = UUID()
    let url: String?
    let image: UIImage
    let time: String
}

extension GalleryItem {
    static let dummyGalleryItem: [GalleryItem] = [
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간"),
        GalleryItem(url: nil, image: UIImage(systemName: "square.fill")!, time: "대충 시간")
    ]
}
