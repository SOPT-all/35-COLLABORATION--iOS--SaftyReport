//
//  LocationCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

protocol LocationCellDelegate: AnyObject {
    func locationIconTapped()
}

class LocationCell: BaseCell {
    
    weak var delegate: LocationCellDelegate?

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
    
    private let tapAreaView = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(smallLocationIcon, locationLabel, locationIcon, tapAreaView)
        
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
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        tapAreaView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationIconTapped))
        tapAreaView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func locationIconTapped() {
        delegate?.locationIconTapped()
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
    
    func updateLocationText(_ text: String) {
        locationLabel.text = text
        locationLabel.textColor = .black // 선택 시 텍스트 색상 변경
    }
}

#Preview {
    ReportDetailViewController()
}
