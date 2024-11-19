//
//  UIStackView.swift
//  saftyReport
//
//  Created by 이지훈 on 11/19/24.
//

import UIKit

extension UIStackView {
    func addStackViewSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
