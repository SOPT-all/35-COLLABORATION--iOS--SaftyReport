//
//  CustomTabBarController.swift
//  saftyReport
//
//  Created by 김희은 on 11/21/24.
//

import UIKit

enum CustomTabBarItem: CaseIterable {
    
    case home, report, prevent, news, myPage
    
    var navViewController: UIViewController {
        switch self {
        case .home: return MainViewController()
        case .report: return ReportViewController()
        case .prevent: return ViewController()
        case .news: return ViewController()
        case .myPage: return ViewController()
        }
    }
    var itemTitle: String? {
        switch self {
        case .home: return "홈"
        case .report: return "안전신고"
        case .prevent: return "범죄예방"
        case .news: return "안전뉴스"
        case .myPage: return "마이페이지"
        }
    }
    var normalItemImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icn_home_line_grey_24px")
        case .report:
            return UIImage(named: "icn_danger_line_grey_24px")
        case .prevent:
            return UIImage(named: "icn_safety_line_grey_24px")
        case .news:
            return UIImage(named: "icn_newspaper_line_grey_24px")
        case .myPage:
            return UIImage(named: "icn_person_line_grey_24px")
        }
    }
    var selectedItemImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icn_home_filled_orange_24px")
        case .report:
            return UIImage(named: "icn_danger_filled_orange_24px")
        case .prevent:
            return UIImage(named: "icn_safety_filled_orange_24px")
        case .news:
            return UIImage(named: "icn_newspaper_filled_orange_24px")
        case .myPage:
            return UIImage(named: "icn_person_filled_orange_24px")
        }
    }
}

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
    }
    
    private func setUI() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = .gray1
        tabBarAppearance.tintColor = .primaryOrange
        
        tabBar.do {
            CustomShadow.shared.applyShadow(to: $0.layer, width: 0, height: 1)
        }
        
        let viewControllers = CustomTabBarItem.allCases.map {
            let viewController = setUpViewController(
                title: $0.itemTitle,
                normalItemImage: $0.normalItemImage,
                selectedItemImage: $0.selectedItemImage,
                viewController: $0.navViewController
            )
            return viewController
        }
        setViewControllers(viewControllers, animated: true)
    }
    
    private func setUpViewController(title: String?,
                            normalItemImage: UIImage?,
                            selectedItemImage: UIImage?,
                             viewController: UIViewController?) -> UIViewController {
        let naviViewController = UINavigationController(rootViewController: viewController ?? ViewController())
        naviViewController.tabBarItem = UITabBarItem(
            title: title ?? "",
            image: normalItemImage ?? UIImage(),
            selectedImage: selectedItemImage ?? UIImage()
        )
        return naviViewController
    }
    
    private func setLayout() {
        
    }
}
