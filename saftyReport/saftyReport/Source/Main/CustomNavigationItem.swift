//
//  CustomNavigationItem.swift
//  saftyReport
//
//  Created by 김희은 on 11/20/24.
//

import UIKit

final class CustomNavigationItem: UINavigationItem {
    
    private let leftLogoButtonImage = UIImage(named: "icn_logo_line_white_24px")
    private let leftArrowButtonImage = UIImage(named: "icn_arrow_left_line_white_24px")
    private let rightChatButtonImage = UIImage(named: "icn_chat_line_white_24px")
    private let rightMenuButtonImage = UIImage(named: "icn_hammenu_line_white_24px")
    
   private lazy var leftButton = UIButton().then {
        $0.setImage(leftLogoButtonImage, for: .normal)
    }
    
   private lazy var backButton = UIButton().then {
        $0.setImage(leftArrowButtonImage, for: .normal)
        //$0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 아직 backButton Action 구현 필요 없음.
    }
    
   private lazy var rightButton = UIButton().then {
        $0.setImage(rightChatButtonImage, for: .normal)
    }
    
   private lazy var rightRightButton = UIButton().then {
        $0.setImage(rightMenuButtonImage, for: .normal)
    }
    
   private lazy var rightButtonStackView = UIStackView.init(arrangedSubviews: [rightButton, rightRightButton]).then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 12
    }
    
    
    // MARK: - 네비게이션 아이템 생성 함수
    
    /// setUpNavigationBar : .back은 back버튼만, .leftRight는 leftIcon, right stackButtons, .backRight는 back버튼과 right stack Buttons로 존재함. CustomNavigationItem.setupNavigationBar(for: .leftRight) 와 같이 사용하면 됨
    public func setUpNavigationBar(for type: NavigationType) {
        switch type {
        case .back:
            self.backBarButtonItem = UIBarButtonItem(customView: backButton)
            self.rightBarButtonItem = nil
        case .leftRight:
            self.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            self.rightBarButtonItem = UIBarButtonItem(customView: rightButtonStackView)
        case .backRight:
            self.backBarButtonItem = UIBarButtonItem(customView: backButton)
            self.rightBarButtonItem = UIBarButtonItem(customView: rightButtonStackView)
        }
    }
    
    public func setUpTitle(title: String?){
        self.title = title ?? ""
    }
}
