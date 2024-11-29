//
//  ContentsCell.swift
//  saftyReport
//
//  Created by OneTen on 11/19/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class ContentsCell: UICollectionViewCell {
    var isChecked = false
    
    var checkboxTappedHandler: ((Bool) -> Void)?
    
    private var imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray3
    }
    
    lazy var checkbox = UIButton().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.setImage(.icnCheckboxISquareUnselectedWhite24Px, for: .normal)
        $0.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubviews(imageView, checkbox)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkbox.snp.makeConstraints {
            $0.trailing.equalTo(imageView.snp.trailing).inset(4.5)
            $0.bottom.equalTo(imageView.snp.bottom).inset(5)
            $0.width.height.equalTo(24)
        }
    }
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
        
        checkbox.setImage(
            isChecked ? .icnCheckboxISquareSelectedWhite24Px : .icnCheckboxISquareUnselectedWhite24Px,
            for: .normal
        )
        
        checkboxTappedHandler?(isChecked)
    }
    
    func configure(item: GalleryPhotoList, isChecked: Bool = false){
        if let imageURL = URL(string: item.photoUrl ?? "") {
            imageView.kf.setImage(with: imageURL)
        }
        
        self.isChecked = isChecked
        self.checkbox.setImage(
            isChecked ? .icnCheckboxISquareSelectedWhite24Px : .icnCheckboxISquareUnselectedWhite24Px,
            for: .normal
        )
    }
    
}
