//
//  GalleryImageView.swift
//  saftyReport
//
//  Created by OneTen on 11/20/24.
//

import UIKit

import SnapKit
import Then

class GalleryImageView: UIView {
    private var imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray3
    }
    
    private var checkbox = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = .icnCheckboxISquareSelectedWhite24Px
    }
    
    private var isChecked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(imageView, checkbox)
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
    
    func checkboxToggle(check: Bool) {
        self.isChecked = check
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
        
        if isChecked {
            checkbox.image = .icnCheckboxISquareSelectedWhite24Px
        } else {
            checkbox.image = .icnCheckboxISquareUnselectedWhite24Px
        }
    }
    
}
