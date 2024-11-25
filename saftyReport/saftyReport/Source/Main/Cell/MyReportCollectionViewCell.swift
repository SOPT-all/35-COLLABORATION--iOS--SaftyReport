//
//  MyReportCollectionViewCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/24/24.
//

import UIKit

class MyReportCollectionViewCell: UICollectionViewCell {
    let cellIdentifier: String = "MyReportCollectionViewCell"
    
    private let myReportView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .white
    }
    
    private var titleLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "title", style: .caption5)
        $0.textAlignment = .center
    }
    
    private var myReportCountLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "총 nn 건", style: .body2)
        $0.textAlignment = .center
    }
    
    private var mySubReportLabel = UILabel().then {
        $0.attributedText = NSAttributedString.styled(text: "생활안전 신고를 가장 많이 했어요", style: .caption8)
        $0.textAlignment = .center
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
    
    private var myMonthlyReportcount = UILabel().then {
        $0.text = "7건"
        $0.textColor = .primaryOrange
        $0.attributedText = NSAttributedString.styled(text: "7건", style: .heading1)
    }
    
    private var subMonthlyReportcount = UILabel().then {
        $0.text = "수민 님의\n신고이력"
        $0.textColor = .gray8
        $0.attributedText = NSAttributedString.styled(text: "수민 님의\n신고이력", style: .caption9)
        $0.numberOfLines = 0
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
                    myReportCountLabel,
                    myReportCountImageView,
                    myReportSubImageView,
                    mySubReportLabel,
                    myMonthlyReportImageView,
                    myMonthlyReportcount,
                    subMonthlyReportcount
                )
    }
    
    private func setLayout() {
        myReportView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(12)
        }
        
        myReportCountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        mySubReportLabel.snp.makeConstraints {
            $0.top.equalTo(myReportCountLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        myReportCountImageView.snp.makeConstraints {
            $0.top.equalTo(mySubReportLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        myReportSubImageView.snp.makeConstraints {
            $0.top.equalTo(myReportCountImageView.snp.bottom).offset(10)
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        myMonthlyReportImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview().inset(14)
        }
        myMonthlyReportcount.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        subMonthlyReportcount.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(myMonthlyReportcount.snp.bottom).offset(4)
        }
    }
    

    
    func configure(with itemIndex: Int) {
        let allViews: [UIView] = [
                    myReportCountLabel,
                    myReportCountImageView,
                    myReportSubImageView,
                    mySubReportLabel,
                    myMonthlyReportImageView,
                    myMonthlyReportcount,
                    subMonthlyReportcount
                ]
                allViews.forEach { $0.isHidden = true }
        
        switch itemIndex {
        case 0:
            titleLabel.text = "나의 올해 신고"
            myReportCountLabel.isHidden = false
            myReportCountImageView.isHidden = false
            myReportSubImageView.isHidden = false
            mySubReportLabel.isHidden = false
        case 1:
            titleLabel.text = "2024년 10월"
            myMonthlyReportImageView.isHidden = false
            myMonthlyReportcount.isHidden = false
            subMonthlyReportcount.isHidden = false
        default:
            allViews.forEach { $0.isHidden = true }
        }
    }
}

extension MyReportCollectionViewCell {
    private func setShadow(toLayer: CALayer) {
        CustomShadow.shared.applyShadow(to: toLayer, width: 1, height: 1)
    }
}

#Preview {
    MyReportCollectionViewCell()
}
