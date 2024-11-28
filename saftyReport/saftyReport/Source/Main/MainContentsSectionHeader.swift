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
        $0.numberOfLines = 1
        $0.attributedText = NSAttributedString.styled(text: "header title", style: .body2)
    }
    var mileageStack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .trailing
        $0.distribution = .equalSpacing
        $0.distribution = .fill
    }
    let leftLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.attributedText = NSAttributedString.styled(text: "마일리지 : ", style: .caption7, alignment: .right)
        $0.textColor = .gray13
    }
    var mileageLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.attributedText = NSAttributedString.styled(text: "", style: .caption7, alignment: .right)
        $0.textColor = .gray13
    }
    let rightLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.attributedText = NSAttributedString.styled(text: "P", style: .caption7, alignment: .right)
        $0.textColor = .gray13
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
        self.addSubviews(headerLabel, mileageStack, moreButton)
        mileageStack.addArrangedSubviews(leftLabel, mileageLabel, rightLabel)
        
        // 초기 상태 설정
        mileageStack.isHidden = true
        moreButton.isHidden = true
    }
    
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        mileageStack.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        leftLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.trailing.equalTo(mileageLabel.snp.leading).offset(-7)
        }
        mileageLabel.snp.makeConstraints {
            $0.trailing.equalTo(rightLabel.snp.leading).offset(-3)
        }
        rightLabel.snp.makeConstraints {
            $0.width.equalTo(12)
        }
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.width.equalTo(42)
        }
    }
    
    func configure(with mainHeaderItem: MainHeaderItem, mileage: Int?) {
        headerLabel.text = mainHeaderItem.title
        
        switch mainHeaderItem.rightHeaderItem {
        case .mileageLabel:
            mileageStack.isHidden = false
            moreButton.isHidden = true
            
            let text = formatNumber(mileage ?? 0)
            mileageLabel.attributedText = NSAttributedString.styled(
                text: text,
                style: .caption7,
                alignment: .right
            )
        case .moreButton:
            mileageStack.isHidden = true
            moreButton.isHidden = false
        default:
            mileageStack.isHidden = true
            moreButton.isHidden = true
        }
    }
    
    func formatNumber(_ number: Int) -> String {
        let beforeNum: Int = number
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(for: beforeNum) ?? "\(number)"
    }
}
