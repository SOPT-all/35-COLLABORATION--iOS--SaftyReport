//
//  Environment.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
