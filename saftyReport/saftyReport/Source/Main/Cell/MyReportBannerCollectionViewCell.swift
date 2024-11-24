//
//  MyReportBannerCollectionViewCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class MyReportBannerCollectionViewCell: UICollectionViewCell {
    let cellIdentifier: String = "MyReportBannerCollectionViewCell"
    
    private let bannerImageView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
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
        self.addSubviews(bannerImageView)
    }
    
    private func setLayout() {
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
