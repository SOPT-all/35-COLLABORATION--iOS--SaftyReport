//
//  CustomTabBarController.swift
//  saftyReport
//
//  Created by 김희은 on 11/21/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let tabBarAppearance = UITabBar.appearance().then {
        $0.backgroundColor = .gray1
        $0.tintColor = .primaryOrange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarShadow()
    }
    
    private func setUpTabBarShadow() {
          CustomShadow.shared.applyShadow(to: tabBar.layer, width: 0, height: 1)
    }
}

extension CustomTabBarController {
    
    public func setNavViewControllers() {
        let viewControllers = CustomTabBarItem.allCases.map {
            let viewController = setUpTabBarItem(
                title: $0.itemTitle ?? "",
                normalItemImage: $0.normalItemImage ?? UIImage(),
                selectedItemImage: $0.selectedItemImage ?? UIImage(),
                viewController: $0.navViewController ?? UIViewController()
            )
            return viewController
        }
        setViewControllers(viewControllers, animated: true)
    }
    
    private func setUpTabBarItem(title: String,
                                 normalItemImage: UIImage,
                                 selectedItemImage: UIImage,
                                 viewController: UIViewController) -> UIViewController {
        let navViewController = UINavigationController(
            rootViewController: viewController
        )
        let tabBarTitleAttributes: [NSAttributedString.Key : Any] = NSAttributedString.styled(
            text: title,
            style: .caption6
        ).attributes(
            at: 0,
            effectiveRange: nil
        )
        
        navViewController.tabBarItem = UITabBarItem(
            title: title,
            image: normalItemImage,
            selectedImage: selectedItemImage
        ).then {
            $0.setTitleTextAttributes(tabBarTitleAttributes, for: .normal)
            $0.setTitleTextAttributes(tabBarTitleAttributes, for: .selected)
        }
        return navViewController
    }
}
