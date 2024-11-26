//
//  ReportCategoryNormalTableViewCell.swift
//  saftyReport
//
//  Created by 김유림 on 11/26/24.
//

import UIKit

class ReportCategoryNormalTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let grayView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.backgroundColor = UIColor.gray3.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .gray13
    }
    
    private let infoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .iconInfoLineBlack16Px
    }
    
    
    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(grayView)
        grayView.addSubviews(titleLabel, infoImageView)
    }
    
    private func setConstraints() {
        grayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        infoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func bind(title: String) {
        titleLabel.attributedText = NSAttributedString.styled(text: title, style: .body4)
    }
}
