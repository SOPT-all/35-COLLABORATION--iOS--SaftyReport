//
//  Environment.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

enum Environment {
    static let HomeURL: String = Bundle.main.infoDictionary?["URL명 적을 곳"] as! String
    static let CategoryURL: String = Bundle.main.infoDictionary?["URL명 적을 곳"] as! String
    static let ReportURL: String = Bundle.main.infoDictionary?["URL명 적을 곳"] as! String
    static let GalleryURL: String = Bundle.main.infoDictionary?["URL명 적을 곳"] as! String
}
