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
    TableItem(image: UIImage.icnSafetyLineBlack24Px, title: "안전"),
    TableItem(image: UIImage.icnCarwheelLineBlack24Px, title: "불법주정차"),
    TableItem(image: UIImage.icnCarLineBlack24Px, title: "자동차/교통위반"),
    TableItem(image: UIImage.icnDangerLineBlack24Px, title: "생활불편"),
    TableItem(image: UIImage.icnFullmenuLineBlack24Px, title: "전체 메뉴 보기"),
    TableItem(image: UIImage.icnCameraLineBlack24Px, title: "촬영하기")
]
