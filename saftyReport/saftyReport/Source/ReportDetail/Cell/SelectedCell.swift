//
//  SelectedCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/29/24.
//

import UIKit

class SelectedImageCell: UICollectionViewCell {
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func configure(with photoList: GalleryPhotoList) {
        if let imageURL = URL(string: photoList.photoUrl ?? "") {
            imageView.kf.setImage(with: imageURL)
        }
    }
}
