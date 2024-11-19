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
    private let titleLabel = UILabel().then {
        $0.text = "신고 유형 선택하기"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.tintColor = .darkGray
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
    }
    
    private let optionsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.isHidden = true
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
        [titleLabel, arrowImageView, containerView].forEach { addSubview($0) }
        containerView.addSubview(optionsStackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
        optionsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
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
            }
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.transform = self.isExpanded ? .init(rotationAngle: .pi) : .identity
            self.optionsStackView.isHidden = !self.isExpanded
            self.layoutIfNeeded()
        }
    }
}
