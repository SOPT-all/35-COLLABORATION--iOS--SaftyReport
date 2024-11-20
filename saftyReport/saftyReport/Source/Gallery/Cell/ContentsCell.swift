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
    private var isChecked = false
    
    private var imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray3
    }
    
    private lazy var checkbox = UIButton().then {
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
        
        if isChecked {
            checkbox.setImage(.icnCheckboxISquareSelectedWhite24Px, for: .normal)
        } else {
            checkbox.setImage(.icnCheckboxISquareUnselectedWhite24Px, for: .normal)
        }
    }

}
