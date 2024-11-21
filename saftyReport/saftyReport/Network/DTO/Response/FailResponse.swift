//
//  FailResponse.swift
//  saftyReport
//
//  Created by OneTen on 11/21/24.
//

import Foundation

// MARK: - FailResponse

struct FailResponse: Codable {
    let status: Int?
    let message: String?
}
