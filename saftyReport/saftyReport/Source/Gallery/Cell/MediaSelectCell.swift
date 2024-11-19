//
//  MediaSelectCell.swift
//  saftyReport
//
//  Created by OneTen on 11/19/24.
//

import UIKit

import SnapKit
import Then

class MediaSelectCell: UICollectionViewCell {
    private let photoLabel = UILabel().then {
        $0.text = "사진"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .primaryOrange
        $0.textAlignment = .center
        $0.backgroundColor = .gray1
    }
    
    private let videoLabel = UILabel().then {
        $0.text = "동영상"
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .gray1
        $0.textAlignment = .center
        $0.backgroundColor = .gray5
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
        contentView.addSubview(photoLabel)
        contentView.addSubview(videoLabel)
    }
    
    private func setLayout() {
        photoLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        videoLabel.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(photoLabel.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}
