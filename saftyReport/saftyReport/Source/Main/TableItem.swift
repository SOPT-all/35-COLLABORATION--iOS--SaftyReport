//
//  TableItem.swift
//  saftyReport
//
//  Created by 김희은 on 11/28/24.
//

import UIKit

struct TableItem {
    let image: UIImage?
    let title: String
    
}

var tableItems: [TableItem] = [
    TableItem(image: UIImage(named: "icn_safety_line_black_24px"), title: "안전"),
    TableItem(image: UIImage(named: "icn_carwheel_line_black_24px"), title: "불법주정차"),
    TableItem(image: UIImage(named: "icn_car_line_black_24px"), title: "자동차/교통위반"),
    TableItem(image: UIImage(named: "icn_danger_line_black_24px"), title: "생활불편"),
    TableItem(image: UIImage(named: "icn_fullmenu_line_black_24px"), title: "전체 메뉴 보기"),
    TableItem(image: UIImage(named: "icn_camera_line_black_24px"), title: "촬영하기")
]

