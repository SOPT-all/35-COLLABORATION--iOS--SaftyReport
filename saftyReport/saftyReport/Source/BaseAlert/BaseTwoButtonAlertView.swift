//
//  BaseTwoButtonAlertView.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class BaseTwoButtonAlertView: UIView {
    
    // MARK: - Properties
    private let alertView = UIView().then {
        $0.backgroundColor = .gray1
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let backgroundButton = UIButton()
    
    private let titleView = UIView().then {
        $0.backgroundColor = .primaryOrange
    }
    
    private let titleLabel = UILabel()
    
    let exitButton = UIButton().then {
        $0.setImage(.icnCrossISelectedWhite16Px, for: .normal)
    }
    
    private let contentView = UIView()
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    let cancelButton = UIButton().then {
        var config = UIButton.Configuration.bordered()
        config.background.cornerRadius = 10
        config.background.strokeColor = .gray5
        config.baseBackgroundColor = .gray1
        config.baseForegroundColor = .gray8
        config.attributedTitle = AttributedString(
            NSAttributedString.styled(text: "취소", style: .body4)
        )
        $0.configuration = config
    }
    
    let confirmButton = UIButton().then {
        var config = UIButton.Configuration.bordered()
        config.background.cornerRadius = 10
        config.background.strokeColor = .primaryLight
        config.baseBackgroundColor = .gray1
        config.baseForegroundColor = .primaryOrange
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
        self.backgroundColor = .gray13Opacity60
    }
    
    private func setHierarchy() {
        self.addSubviews(backgroundButton, alertView)
        alertView.addSubviews(titleView, contentView, buttonStackView)
        titleView.addSubviews(titleLabel, exitButton)
        buttonStackView.addArrangedSubviews(cancelButton, confirmButton)
    }
    
    private func setConstraints() {
        backgroundButton.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
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
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(21.5)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    func setAlert(_ title: String, _ customView: UIView) {
        titleLabel.attributedText = NSAttributedString.styled(text: title, style: .body2)
        
        contentView.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
