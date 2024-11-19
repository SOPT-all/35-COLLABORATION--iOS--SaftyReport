//
//  RepoetTypeCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/19/24.
//

import UIKit

import SnapKit
import Then

class ReportTypeCell: UICollectionViewCell, ConfigurableCell {
    static let reuseIdentifier = "ReportTypeCell"
    
    private let mockReportView = MockReportView()
    private var isExpanded = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(mockReportView)
        mockReportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mockReportView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        isExpanded.toggle()
        UIView.animate(withDuration: 0.3) {
            self.mockReportView.updateExpandedState(self.isExpanded)
        }
    }
    
    func configure(with item: ReportDetailItem) {
        // mockReportView의 설정이 필요한 경우 여기서 구현
    }
}
