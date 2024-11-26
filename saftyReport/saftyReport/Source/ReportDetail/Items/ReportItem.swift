//
//  ReportItem.swift
//  saftyReport
//
//  Created by 이지훈 on 11/22/24.
//

import Foundation

struct ReportDetailItem: Hashable {
    let id = UUID()
    let section: ReportDetailSection
    let title: String
    let isRequired: Bool
    let placeholder: String?
    let showInfoIcon: Bool

}
