//
//  ContentsCell.swift
//  saftyReport
//
//  Created by OneTen on 11/19/24.
//

import UIKit

import SnapKit
import Then

class ContentsCell: UICollectionViewCell {
    private let dateLabel = UILabel().then {
        $0.attributedText = .styled(text: "2024년 11월 14일", style: .body2)
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .gray13
    }
    
    private var imageListView = GalleryImageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubviews(dateLabel, imageListView)
    }
    
    private func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(20)
        }
        
        imageListView.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.width.equalTo(110)
            $0.height.equalTo(110)
        }
    }
    
}
