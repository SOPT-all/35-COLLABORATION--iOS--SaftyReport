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
        $0.image = UIImage(systemName: "chart.pie.fill")
        //$0.image = UIImage(named: "chrat.bar.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .primaryOrange
    }
    
    private var myMonthlyReportImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chart.pie.fill")
        //$0.image = UIImage(named: "chart.pie.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .primaryOrange
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
                    mySubReportLabel,
                    myMonthlyReportImageView
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
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        myMonthlyReportImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview().inset(14)
        }
    }
    

    
    func configure(with itemIndex: Int) {
        let allViews: [UIView] = [
                    myReportCountLabel,
                    myReportCountImageView,
                    mySubReportLabel,
                    myMonthlyReportImageView
                ]
                allViews.forEach { $0.isHidden = true }
        
        switch itemIndex {
        case 0:
            titleLabel.text = "나의 올해 신고"
            myReportCountLabel.isHidden = false
            myReportCountImageView.isHidden = false
            mySubReportLabel.isHidden = false
        case 1:
            titleLabel.text = "2024년 10월"
            myMonthlyReportImageView.isHidden = false
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
