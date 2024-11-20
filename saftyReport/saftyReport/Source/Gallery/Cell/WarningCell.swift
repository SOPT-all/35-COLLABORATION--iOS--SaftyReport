//
//  WarningCell.swift
//  saftyReport
//
//  Created by OneTen on 11/19/24.
//

import UIKit

import SnapKit
import Then

class WarningCell: UICollectionViewCell {
    private let warningCellView = UIView().then {
        $0.backgroundColor = .gray13Opacity5
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    private let warningStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let warningLabel = UILabel().then {
        $0.attributedText = .styled(text: "촬영시차가 5분 이상인 사진을 2장 이상 첨부해주세요", style: .caption1)
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .primaryRed
    }
    
    private let warningImageView = UIImageView().then {
        $0.image = .iconAlertLineRed16Px
        $0.contentMode = .scaleAspectFit
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        contentView.addSubview(warningCellView)
        warningCellView.addSubview(warningStackView)
        warningStackView.addArrangedSubviews(warningImageView, warningLabel)
    }
    
    private func setLayout() {
        warningCellView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        warningStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        warningImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
        warningLabel.snp.makeConstraints {
            $0.leading.equalTo(warningImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-44)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(250)
            $0.height.equalTo(14)
        }
    }
    
}
