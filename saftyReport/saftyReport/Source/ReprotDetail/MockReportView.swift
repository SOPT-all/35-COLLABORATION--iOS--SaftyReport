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
    let mainButton = UIButton().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .darkGray
    }
    
    private let optionsContainer = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.isHidden = true
    }
    
    private let optionsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    var isExpanded: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [mainButton, arrowImageView].forEach { addSubview($0) }
        
        // 메인 버튼 설정
        mainButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        mainButton.setTitle("신고 유형을 선택해주세요", for: .normal)
        mainButton.setTitleColor(.darkGray, for: .normal)
        
        // 화살표 이미지
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(mainButton)
            $0.trailing.equalTo(mainButton).offset(-16)
            $0.width.height.equalTo(20)
        }
        
        // 옵션 컨테이너 설정 (window에 추가)
        DispatchQueue.main.async {
            if let window = self.window {
                window.addSubview(self.optionsContainer)
                self.optionsContainer.addSubview(self.optionsStackView)
                
                self.optionsStackView.snp.makeConstraints {
                    $0.edges.equalToSuperview().inset(16)
                }
            }
        }
        
        setupOptions()
    }
    
    private func setupOptions() {
        let options = ["소화전", "교차로 모퉁이", "버스 정류소", "황단보도",
                      "어린이 보호구역", "인도", "기타", "장애인 전용구역", "전환경차 충전구역"]
        
        options.forEach { option in
            let button = UIButton(type: .system).then {
                $0.setTitle(option, for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.contentHorizontalAlignment = .left
                $0.titleLabel?.font = .systemFont(ofSize: 14)
                $0.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            }
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            mainButton.setTitle(title, for: .normal)
            mainButton.setTitleColor(.black, for: .normal)
            isExpanded = false
        }
    }
    
    private func updateUI() {
        guard let window = self.window else { return }
        
        // 메인 버튼의 전체 화면 좌표 계산
        let buttonFrame = mainButton.convert(mainButton.bounds, to: window)
        
        if isExpanded {
            optionsContainer.frame = CGRect(
                x: buttonFrame.minX,
                y: buttonFrame.maxY + 8,
                width: buttonFrame.width,
                height: 400 // 필요한 높이로 조정
            )
            optionsContainer.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.transform = self.isExpanded ? .init(rotationAngle: .pi) : .identity
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
