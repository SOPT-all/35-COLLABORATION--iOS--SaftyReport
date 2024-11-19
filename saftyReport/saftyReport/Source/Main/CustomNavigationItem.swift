//
//  CustomNavigationItem.swift
//  saftyReport
//
//  Created by 김희은 on 11/20/24.
//

import UIKit

class CustomNavigationItem: UINavigationItem {
    
    let leftLogoButtonImage = UIImage(named: "icn_logo_line_white_24px")
    let leftArrowButtonImage = UIImage(named: "icn_arrow_left_line_white_24px")
    let rightChatButtonImage = UIImage(named: "icn_chat_line_white_24px")
    let rightMenuButtonImage = UIImage(named: "icn_hammenu_line_white_24px")
    
    lazy var leftButton = UIButton().then {
        $0.setImage(leftLogoButtonImage, for: .normal)
    }
    
    lazy var backButton = UIButton().then {
        $0.setImage(leftArrowButtonImage, for: .normal)
        //$0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    lazy var rightButton = UIButton().then {
        $0.setImage(rightChatButtonImage, for: .normal)
    }
    
    lazy var rightRightButton = UIButton().then {
        $0.setImage(rightMenuButtonImage, for: .normal)
    }
    
    lazy var rightButtonStackView = UIStackView.init(arrangedSubviews: [rightButton, rightRightButton]).then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 12
    }
    
    func setupNavigationBar(for type: NavigationType) {
        switch type {
        case .back:
            self.backBarButtonItem = UIBarButtonItem(customView: backButton)
            self.rightBarButtonItem = nil // 비활성화
        case .leftRight:
            self.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            self.rightBarButtonItem = UIBarButtonItem(customView: rightButtonStackView)
        case .backRight:
            self.backBarButtonItem = UIBarButtonItem(customView: backButton)
            self.rightBarButtonItem = UIBarButtonItem(customView: rightButtonStackView)
        }
    }
    
    func settingTitle(title: String?){
        self.title = title ?? ""
    }
}
