//
//  ReportCategory.swift
//  saftyReport
//
//  Created by 김유림 on 11/27/24.
//

import Foundation

struct CustomCategory {
    enum Section: CaseIterable {
        case safety
        case parking
        case traffic
        case environment
    }
    
    struct Item: Hashable {
        let section: Section
        let name: String
        let description: String
        var isExpanded: Bool
    }
    
    static func configureSection(categoryID: Int) -> CustomCategory.Section {
        switch categoryID {
        case 1:
            return .safety
        case 2:
            return .parking
        case 3:
            return .traffic
        case 4:
            return .environment
        default:
            return .safety
        }
    }
}
