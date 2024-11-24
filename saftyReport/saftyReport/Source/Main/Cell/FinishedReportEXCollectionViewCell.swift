//
//  FinishedReportEXCollectionViewCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class FinishedReportEXCollectionViewCell: UICollectionViewCell {
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 9
    }
    
    private let beforeImageView = UIImageView().then {
        $0.image = UIImage(named: "image_before")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    private let afterImageview = UIImageView().then {
        $0.image = UIImage(named: "image_after")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
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
        self.addSubview(stackView)
        stackView.addSubviews(beforeImageView, afterImageview)
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        beforeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
        }
        afterImageview.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
