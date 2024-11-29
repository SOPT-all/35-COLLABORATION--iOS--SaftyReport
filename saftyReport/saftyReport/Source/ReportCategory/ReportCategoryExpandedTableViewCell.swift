//
//  ReportCategoryExpandedTableViewCell.swift
//  saftyReport
//
//  Created by 김유림 on 11/27/24.
//

import UIKit

class ReportCategoryExpandedTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let grayView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.backgroundColor = UIColor.gray3.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .gray13
    }
    
    private let reportButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(NSAttributedString.styled(
            text: "신고하기",
            style: .body4))
        config.background.cornerRadius = 5
        config.baseBackgroundColor = .primaryOrange
        config.baseForegroundColor = .gray1
        $0.configuration = config
    }
    
    private let descriptionView = UIView().then {
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 10
    }
    
    private let descriptionTitleLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(
            text: "아래의 경우 신고할 수 있는 유형입니다.",
            style: .caption4)
        $0.textColor = .gray13
    }
    
    private let descriptionContentLabel = UILabel().then {
        $0.textColor = .gray13
        $0.numberOfLines = 0
    }
    
    // MARK: - Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(grayView)
        grayView.addSubviews(titleLabel, reportButton, descriptionView)
        descriptionView.addSubviews(descriptionTitleLabel, descriptionContentLabel)
    }
    
    private func setConstraints() {
        grayView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        reportButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        descriptionContentLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func bind(item: CustomCategory.Item, at target: Any?, reportButtonAction: Selector) {
        titleLabel.attributedText = NSAttributedString.styled(
            text: item.name,
            style: .body4)
        
        descriptionContentLabel.attributedText = NSAttributedString.styled(
            text: item.description,
            style: .caption4)
        
        reportButton.addTarget(target, action: reportButtonAction, for: .touchUpInside)
    }
}
