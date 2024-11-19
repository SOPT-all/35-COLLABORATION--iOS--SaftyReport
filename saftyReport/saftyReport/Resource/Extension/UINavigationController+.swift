//
//  UINavigationController+.swift
//  saftyReport
//
//  Created by 김희은 on 11/20/24.
//

import UIKit

extension UINavigationController {
    func setUpNavigationBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.primaryOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray1]
        appearance.titleTextAttributes[.font] = TextStyle.heading2.font
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
