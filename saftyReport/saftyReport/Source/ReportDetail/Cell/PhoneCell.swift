
//
//  PhoneCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

protocol PhoneCellDelegate: AnyObject {
    func phoneNumberDidChange(_ number: String)
}

class PhoneCell: BaseCell {
    
    weak var delegate: PhoneCellDelegate?
    
    private let textField = UITextField().then {
        $0.backgroundColor = .gray3
        $0.layer.cornerRadius = 8
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        $0.leftViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configure(with item: ReportDetailItem) {
        super.configure(with: item)
        
        let attributedPlaceholder = NSAttributedString.styled(
            text: item.placeholder ?? "",
            style: .body9,
            alignment: .left
        )
        textField.attributedPlaceholder = attributedPlaceholder
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
         delegate?.phoneNumberDidChange(textField.text ?? "")
     }
}

#Preview {
    ReportDetailViewController()
}
