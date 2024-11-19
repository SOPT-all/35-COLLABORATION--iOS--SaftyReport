//
//  ContentsCell.swift
//  saftyReport
//
//  Created by OneTen on 11/19/24.
//

import UIKit

class ContentsCell: UICollectionViewCell {
    private let photoLabel = UILabel().then {
        $0.attributedText = .styled(text: "사진", style: .body4)
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .primaryOrange
    }
    
    private let videoLabel = UILabel().then {
        $0.attributedText = .styled(text: "동영상", style: .body4)
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .gray1
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
        contentView.addSubview(photoLabel)
        contentView.addSubview(videoLabel)
    }
    
    private func setLayout() {
        photoLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
