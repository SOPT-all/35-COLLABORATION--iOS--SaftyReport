//
//  RepoetTypeCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/19/24.
//

import UIKit

import SnapKit
import Then

class ReportTypeCell: BaseCell {
    private let mockReportView = MockReportView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(mockReportView)
        mockReportView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTapGesture() {
        mockReportView.mainButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        mockReportView.isExpanded.toggle()
    }
    
    override func configure(with item: ReportDetailItem) {
        super.configure(with: item)
    }
}
