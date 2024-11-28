//
//  BannerCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class BannerCell: UICollectionViewCell {
    let cellIdentifier: String = "BannerCell"
    
    let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubviews(bannerImageView)
    }
    
    private func setLayout() {
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(image: String) {
        if let image = UIImage(named: image) {
            bannerImageView.image = image
        }
    }
}
