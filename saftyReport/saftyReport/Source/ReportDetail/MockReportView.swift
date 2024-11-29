//
//  MockReportView.swift
//  saftyReport
//
//  Created by 이지훈 on 11/19/24.
//

import UIKit

import SnapKit
import Then

class MockReportView: UIView {
    
    let topOptions = [
        "소화전",
        "교차로 모퉁이",
        "버스 정류소",
        "황단보도",
        "어린이 보호구역",
        "인도",
        "기타"
    ]
    
    let bottomOptions = [
        "장애인 전용구역",
        "소방차 전용구역",
        "친환경차 충전구역"
    ]
    
    let mainButton = UIButton().then {
        $0.backgroundColor = .gray3
        $0.contentHorizontalAlignment = .left
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 0
        )
        configuration.baseForegroundColor = .darkGray
        
        $0.configuration = configuration
    }
    
    let optionsContainer = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.backgroundColor = .gray3
        CustomShadow.shared.applyShadow(to: $0.layer, width: 0, height: -4)
        $0.isHidden = true
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage.icnArrowDownLineBlack24Px
        $0.tintColor = .darkGray
    }
    
    private let optionsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .fillProportionally
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .gray13Opacity10
    }
    
    private lazy var topStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    private lazy var bottomStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    var isExpanded: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [mainButton, arrowImageView].forEach { addSubview($0) }
        
        mainButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        mainButton.setTitle("신고 유형을 선택해주세요", for: .normal)
        mainButton.setTitleColor(.darkGray, for: .normal)
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(mainButton)
            $0.trailing.equalTo(mainButton).offset(-16)
            $0.width.height.equalTo(20)
        }
        
        DispatchQueue.main.async {
            if let window = self.window {
                window.addSubview(self.optionsContainer)
                self.optionsContainer.addSubview(self.optionsStackView)
                self.optionsStackView.snp.makeConstraints {
                    $0.edges.equalToSuperview().inset(16)
                }
                self.dividerView.snp.makeConstraints {
                    $0.height.equalTo(2)
                }
            }
        }
        
        setupOptions()
    }
    
    private func setupCornerRadius() {
        mainButton.layer.cornerRadius = 15
        mainButton.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    private func setupOptions() {
        var currentRowStackView: UIStackView?
        var currentButtonCount = 0
        
        topOptions.forEach { option in
            // "기타"는 단독으로 표시
            
            if topOptions.count%2 == 0 && option == topOptions.last {
                let button = setButton(buttonTitle: option)
                let singleButtonStack = UIStackView().then {
                    $0.axis = .horizontal
                    $0.spacing = 10
                    $0.alignment = .fill
                }
                
                singleButtonStack.addArrangedSubview(button)
                topStackView.addArrangedSubview(singleButtonStack)
                return
            } else {
                // 새로운 Row StackView가 필요한 경우 생성
                if currentRowStackView == nil || currentButtonCount == 2 {
                    currentRowStackView = UIStackView().then {
                        $0.axis = .horizontal
                        $0.spacing = 10
                        $0.alignment = .fill
                        $0.distribution = .fillEqually
                    }
                    topStackView.addArrangedSubview(currentRowStackView!)
                    
                    print(currentButtonCount, topStackView.arrangedSubviews)
                    currentButtonCount = 0
                }
                
                // 버튼 생성 및 Row StackView에 추가
                if let currentRow = currentRowStackView {
                    let button = setButton(buttonTitle: option)
                    currentRow.addArrangedSubview(button)
                    currentButtonCount += 1
                }
            }
        }
        
        var bottomCurrentRowStackView: UIStackView?
        var bottomCurrentButtonCount = 0
        bottomOptions.forEach { option in
            if bottomCurrentRowStackView == nil || bottomCurrentButtonCount == 2 {
                bottomCurrentRowStackView = UIStackView().then {
                    $0.axis = .horizontal
                    $0.spacing = 10
                    $0.alignment = .fill
                    $0.distribution = .fillEqually
                }
                bottomStackView.addArrangedSubview(bottomCurrentRowStackView!)
                
                print(bottomCurrentButtonCount, bottomStackView.arrangedSubviews)
                currentButtonCount = 0
            }
            
            // 버튼 생성 및 Row StackView에 추가
            if let currentRow = bottomCurrentRowStackView {
                let button = setButton(buttonTitle: option)
                currentRow.addArrangedSubview(button)
                bottomCurrentButtonCount += 1
            }
        }
        
        optionsStackView.addArrangedSubviews(topStackView, dividerView, bottomStackView)
    }
    
    private func setButton(buttonTitle: String) -> UIButton {
        let button = UIButton().then {
            let attributedText = NSAttributedString.styled(text: buttonTitle, style: .body6)
            $0.setAttributedTitle(attributedText, for: .normal)
            $0.setTitle(buttonTitle, for: .normal)
            $0.setTitleColor(.gray13, for: .normal)
            $0.contentHorizontalAlignment = .center
            $0.titleLabel?.font = .systemFont(ofSize: 14)
            $0.backgroundColor = .gray1
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        }
        return button
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            var newConfiguration = mainButton.configuration
            newConfiguration?.baseForegroundColor = .black
            mainButton.configuration = newConfiguration
            mainButton.setTitle(title, for: .normal)
            isExpanded = false
        }
    }
    
    private func updateUI() {
        guard let window = self.window else { return }
        
        let buttonFrame = mainButton.convert(mainButton.bounds, to: window)
        
        if isExpanded {
            optionsContainer.frame = CGRect(
                x: buttonFrame.minX,
                y: buttonFrame.maxY + 8,
                width: buttonFrame.width,
                height: window.frame.height * 0.5
            )
            optionsContainer.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.image = self.isExpanded ?
            UIImage.icnArrowUpLineBlack24Px:
            UIImage.icnArrowDownLineBlack24Px
            self.optionsContainer.alpha = self.isExpanded ? 1 : 0
        } completion: { _ in
            if !self.isExpanded {
                self.optionsContainer.isHidden = true
            }
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        optionsContainer.removeFromSuperview()
    }
}
