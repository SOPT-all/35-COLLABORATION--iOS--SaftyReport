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
        $0.attributedText = .styled(text: "사진", style: .body4)
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .primary
    }
    
    private let videoLabel = UILabel().then {
        $0.attributedText = .styled(text: "동영상", style: .body4)
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .gray1
    }
    
    
    private func setUI(){
        contentView.addSubview(photoLabel)
        contentView.addSubview(videoLabel)
    }
    
    private func setLayout() {
        photoLabel.snp.makeConstraints {
            <#code#>
        }
        
        videoLabel.snp.makeConstraints {
            
        }
    }
    
}
