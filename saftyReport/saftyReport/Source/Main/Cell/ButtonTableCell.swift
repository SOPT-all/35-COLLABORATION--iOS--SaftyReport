//
//  ButtonTableCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/28/24.
//

import UIKit

import SnapKit
import Then

class ButtonTableCell: UITableViewCell {
    lazy var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var titleLabel = UILabel().then {
        $0.textColor = .gray13
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(iconImageView, titleLabel)
    }

    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with tableItem: TableItem) {
        iconImageView.image = tableItem.image
        titleLabel.attributedText = .styled(text: tableItem.title, style: .body9, alignment: .left)
    }
}
