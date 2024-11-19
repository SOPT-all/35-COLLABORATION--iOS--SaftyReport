//
//  Shadow+.swift
//  saftyReport
//
//  Created by 이지훈 on 11/20/24.
//

import UIKit

class CustomShadow {
   static let shared = CustomShadow()
   
   func applyShadow(to layer: CALayer) {
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOpacity = 0.1
       layer.shadowOffset = CGSize(width: 0, height: 4)
       layer.shadowRadius = 30
   }
}
