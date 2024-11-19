//
//  UIView.swift
//  saftyReport
//
//  Created by 이지훈 on 11/19/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
