//
//  MainContentsSectionHeader.swift
//  saftyReport
//
//  Created by 김희은 on 11/23/24.
//

import UIKit

import SnapKit
import Then

class MainContentsSectionHeader: UICollectionReusableView {
    static let identifier = "MainContentsSectionHeader"
    
    let headerLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = " "
        $0.attributedText = NSAttributedString.styled(text: "header title", style: .body2)
    }
    
    let mileageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = NSAttributedString.styled(text: "마일리지 : 5,000,000 P", style: .caption7)
    }
    
    let moreButton = UIButton().then {
        $0.backgroundColor = .gray13Opacity5
        $0.setAttributedTitle(NSAttributedString.styled(text: "더보기", style: .caption7), for: .normal)
        $0.setTitleColor(.gray13, for: .normal)
        $0.layer.cornerRadius = 11
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(headerLabel, mileageLabel, moreButton)
        // 초기 상태 설정
        mileageLabel.isHidden = true
        moreButton.isHidden = true
    }
    
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        mileageLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.width.equalTo(42)
        }
    }
    
    func configure(with header: MainContentsItem) {
        if header == .myReport {
            headerLabel.text = "올해 나의 신고"
            mileageLabel.isHidden = false
            moreButton.isHidden = true
        } else {
            headerLabel.text = "주요 처리 사례"
            mileageLabel.isHidden = true
            moreButton.isHidden = false
        }
    }
}

#Preview {
    MainContentsSectionHeader()
}
