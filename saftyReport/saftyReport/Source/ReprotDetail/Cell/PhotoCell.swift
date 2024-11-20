//
//  PhotoCell.swift
//  Solo
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class PhotoCell: BaseCell {
    private let photoButton = UIButton().then {
        let attributedTitle = NSAttributedString.styled(
              text: "사진을 추가해주세요",
              style: .body9,
              alignment: .center
          )
        $0.backgroundColor = .gray3
        $0.layer.cornerRadius = 8
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.setTitleColor(.gray7, for: .normal)
    }
    
    private let cameraButton = UIButton().then {
        let image = UIImage(named: "btn_i_camera")
        $0.setImage(image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
     
    private let folderButton = UIButton().then {
        let image = UIImage(named: "btn_i_folder")
        $0.setImage(image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [photoButton, buttonStackView].forEach { contentView.addSubview($0) }
        
        [cameraButton, folderButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(90)
        }
        
        [cameraButton, folderButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(32)
            }
        }
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
    }
}

#Preview {
    ReportDetailViewController()
}
