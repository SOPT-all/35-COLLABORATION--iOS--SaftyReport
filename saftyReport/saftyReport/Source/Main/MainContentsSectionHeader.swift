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
        //self.backgroundColor = .gray10
        self.addSubviews(headerLabel, mileageLabel)//, button)
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
//        moreButton.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(16)
//            $0.centerY.equalToSuperview()
//        }
    }
}

#Preview {
    MainContentsSectionHeader()
}
