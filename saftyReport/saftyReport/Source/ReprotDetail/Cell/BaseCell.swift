//
//  BaseCell.swift
//  Solo
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class BaseCell: UICollectionViewCell, ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: self) }
    
    let titleLabel = UILabel().then {
        let attributedText = NSAttributedString.styled(
            text: "",
            style: .body4
        )
        $0.attributedText = attributedText
    }
    
    let requiredMark = UILabel().then {
        $0.text = "*"
        $0.textColor = .primaryOrange
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBaseUI() {
        [titleLabel, requiredMark].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }
        
        requiredMark.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(titleLabel)
        }
    }
    
    func configure(with item: ReportDetailItem) {
        let attributedText = NSAttributedString.styled(
            text: item.title,
            style: .body4
        )
        titleLabel.attributedText = attributedText
        requiredMark.isHidden = !item.isRequired
    }
}
