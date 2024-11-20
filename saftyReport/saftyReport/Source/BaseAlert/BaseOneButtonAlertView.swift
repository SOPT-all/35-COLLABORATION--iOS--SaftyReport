//
//  BaseOneButtonAlertView.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

import SnapKit
import Then

enum AlertMode {
    case alarm
    case info
}

class BaseOneButtonAlertView: UIView {
    // MARK: - Properties
    private let titleView = UIView().then {
        $0.backgroundColor = .primaryOrange
    }
    
    private let titleLabel = UILabel()
    
    private let exitButton = UIButton()
    
    private let contentView = UIView()
    
    private let confirmButton = UIButton().then {
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .gray1
        config.baseForegroundColor = .gray8
        config.background.strokeColor = .gray5
        config.attributedTitle = AttributedString(
            NSAttributedString.styled(text: "확인", style: .body4)
            )
        $0.configuration = config
    }
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    private func setHierarchy() {
        self.addSubviews(titleView, contentView, confirmButton)
        titleView.addSubviews(titleLabel, exitButton)
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(335)
        }
        
        titleView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(21.5)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    func setAlertTheme(_ title: String, _ mode: AlertMode) {
        titleLabel.attributedText = NSAttributedString.styled(text: title, style: .body2)
        
        switch mode {
        case .alarm:
            exitButton.setImage(.icnCrossISelectedWhite16Px, for: .normal)
            exitButton.isEnabled = true
            
        case .info:
            exitButton.setImage(.icnSoundWhite24Px, for: .normal)
            exitButton.isEnabled = false
        }
    }
}
