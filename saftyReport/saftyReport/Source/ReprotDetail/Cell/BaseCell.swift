//
//  BaseCell.swift
//  Solo
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class BaseCell: UICollectionViewCell {
    static var reuseIdentifier: String { return String(describing: self) }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let requiredMark = UILabel().then {
        $0.text = "*"
        $0.textColor = .red
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBaseUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(requiredMark)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        requiredMark.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(titleLabel)
        }
    }
    
    func configure(with item: ReprotDetailItem) {
        titleLabel.text = item.title
        requiredMark.isHidden = !item.isRequired
    }
}
