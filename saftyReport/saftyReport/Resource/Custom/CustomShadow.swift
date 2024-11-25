//
//  Shadow+.swift
//  saftyReport
//
//  Created by 이지훈 on 11/20/24.
//

import UIKit

class CustomShadow {
   static let shared = CustomShadow()
   
    func applyShadow(to layer: CALayer, width: Int, height: Int) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -4) // 위쪽으로만 그림자
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}
