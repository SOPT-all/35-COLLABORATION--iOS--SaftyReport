//
//  MainItem.swift
//  saftyReport
//
//  Created by 김희은 on 11/27/24.
//

import UIKit

enum MainContentSection {
    case myReport
    case banner
    case finishedReport
}

struct MainHeaderItem: Hashable {
    let ID = UUID()
    let section: MainContentSection
    let title: String?
    let rightHeaderItem: RightHeaderItem?
}

enum RightHeaderItem {
    case moreButton
    case mileageLabel
}
