//
//  MyReportCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/24/24.
//

import UIKit

class MyReportCell: UICollectionViewCell {
    let cellIdentifier: String = "MyReportCell"
    
    private let myReportView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .white
    }
    
    private var titleLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "title", style: .caption5, alignment: .center)
    }
    
    private let totalCountStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 3
    }
    
    private var totalLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "총 ", style: .body2)
        $0.textColor = .gray13
    }
    private var countLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "nn", style: .body2)
        $0.textColor = .primaryOrange
    }
    private var unitLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "건", style: .body2)
        $0.textColor = .gray13
    }
    
    private let reportCategoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    private let subReportTargetLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "생활안전 신고", style: .caption8)
        $0.textColor = .primaryOrange
    }
    
    private let subReportLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "를 가장 많이 했어요", style: .caption9)
        $0.textColor = .gray8
    }
    
    private var myReportCountImageView = UIImageView().then {
        $0.image = UIImage(named: "graph_year_report")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .primaryOrange
    }
    
    private var myReportSubImageView = UIImageView().then {
        $0.image = UIImage(named: "sub_graph_month_report")
        $0.contentMode = .scaleAspectFit
    }
    
    private var myMonthlyReportImageView = UIImageView().then {
        $0.image = UIImage(named: "graph_month_report")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .primaryOrange
    }
    
    private let myMonthlyReportCountStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private var myMonthlyReportCountTargetLabel = UILabel().then {
        $0.textColor = .primaryOrange
        $0.attributedText = NSAttributedString.styled(text: "7", style: .heading1)
    }
    
    private var myMonthlyReportCountLabel = UILabel().then {
        $0.textColor = .gray13
        $0.attributedText = NSAttributedString.styled(text: "건", style: .heading1)
    }
    
    private var subMonthlyReportCount = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "수민 님의\n신고이력", style: .caption9)
        $0.numberOfLines = 0
        $0.textColor = .gray8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setShadow(toLayer: self.layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(myReportView)
        
        myReportView.addSubviews(
                    titleLabel,
                    totalCountStackView,
                    myReportCountImageView,
                    myReportSubImageView,
                    reportCategoryStackView,
                    myMonthlyReportImageView,
                    myMonthlyReportCountStackView,
                    subMonthlyReportCount
                )
        totalCountStackView.addArrangedSubviews(
            totalLabel,
            countLabel,
            unitLabel
        )
        reportCategoryStackView.addArrangedSubviews(
            subReportTargetLabel,
            subReportLabel
        )
        myMonthlyReportCountStackView.addArrangedSubviews(
            myMonthlyReportCountTargetLabel,
            myMonthlyReportCountLabel
        )
        
    }
    
    private func setLayout() {
        myReportView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        totalCountStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(reportCategoryStackView.snp.top).offset(-4)
            $0.centerX.equalToSuperview()
        }
        
        reportCategoryStackView.snp.makeConstraints {
            $0.bottom.equalTo(myReportCountImageView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        myReportCountImageView.snp.makeConstraints {
            $0.bottom.equalTo(myReportSubImageView.snp.top).offset(-11)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        myReportSubImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        
        myMonthlyReportImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview().inset(14)
        }
        
        myMonthlyReportCountStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(myMonthlyReportImageView).offset(-12.5)
        }
        
        subMonthlyReportCount.snp.makeConstraints {
            $0.top.equalTo(myMonthlyReportCountStackView.snp.bottom).offset(4)
            $0.centerX.equalTo(myMonthlyReportCountStackView)
            $0.height.equalTo(21)
        }
    }
    
    func configure(with itemIndex: Int) {
        let allViews: [UIView] = [
            totalCountStackView,
            myReportCountImageView,
            myReportSubImageView,
            myReportCountImageView,
            myMonthlyReportImageView,
            myMonthlyReportCountStackView,
            reportCategoryStackView,
            subMonthlyReportCount
        ]
        allViews.forEach { $0.isHidden = true }
        
        switch itemIndex {
        case 0:
            titleLabel.text = "나의 올해 신고"
            totalCountStackView.isHidden = false
            myReportCountImageView.isHidden = false
            myReportSubImageView.isHidden = false
            reportCategoryStackView.isHidden = false
            myReportCountImageView.isHidden = false
        case 1:
            titleLabel.text = "2024년 10월"
            myMonthlyReportImageView.isHidden = false
            myMonthlyReportCountStackView.isHidden = false
            subMonthlyReportCount.isHidden = false
        default:
            allViews.forEach { $0.isHidden = true }
        }
    }
}

extension MyReportCell {
    private func setShadow(toLayer: CALayer) {
        CustomShadow.shared.applyShadow(to: toLayer, width: 1, height: 1)
    }
}
