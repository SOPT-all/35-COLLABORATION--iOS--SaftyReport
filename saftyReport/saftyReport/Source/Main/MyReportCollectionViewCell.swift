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
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setShadow(toLayer: myReportView.layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(myReportView)
    }
    
    private func setLayout() {
        myReportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setShadow(toLayer: CALayer) {
        CustomShadow.shared.applyShadow(to: toLayer, width: 1, height: 1)
    }
}
