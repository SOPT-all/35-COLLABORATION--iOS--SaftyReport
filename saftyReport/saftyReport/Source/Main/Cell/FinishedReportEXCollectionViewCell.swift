//
//  FinishedReportEXCollectionViewCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class FinishedReportEXCollectionViewCell: UICollectionViewCell {
    private let myReportView = UIView().then {
        $0.backgroundColor = .gray3
        $0.layer.cornerRadius = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(myReportView)
    }
    
    private func setLayout() {
        myReportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
