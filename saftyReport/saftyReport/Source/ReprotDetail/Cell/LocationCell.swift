//
//  LocationCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class LocationCell: BaseCell {
    private let smallLocationIcon = UIImageView().then {
        let image = UIImage(named: "icn_location_line_black_24px")
        $0.image = image
        $0.contentMode = .scaleAspectFit
    }
    
    private let locationLabel = UILabel().then {
        let attributedText = NSAttributedString.styled(
            text: "지역을 입력해주세요",
            style: .body9
        )
        $0.attributedText = attributedText
        $0.textColor = .gray6
    }
    
    private let locationIcon = UIImageView().then {
        let image = UIImage(named: "btn_i_location")
        $0.image = image
        $0.tintColor = .gray6
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(smallLocationIcon, locationLabel, locationIcon)
        
        smallLocationIcon.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.size.equalTo(12)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerY.equalTo(smallLocationIcon)
            $0.leading.equalTo(smallLocationIcon.snp.trailing).offset(4)
        }
        
        locationIcon.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(10)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    override func configure(with item: ReportDetailItem) {
        super.configure(with: item)
        if let placeholder = item.placeholder {
            let attributedText = NSAttributedString.styled(
                text: placeholder,
                style: .body9
            )
            locationLabel.attributedText = attributedText
        }
    }
}

#Preview {
    ReportDetailViewController()
}
