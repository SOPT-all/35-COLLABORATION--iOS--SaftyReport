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
    weak var delegate: ReportTypeCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAction()
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
    
    private func setupAction() {
        mockReportView.mainButton.addTarget(
            self,
            action: #selector(mainButtonTapped),
            for: .touchUpInside
        )
    }
    
    func updateTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
    
    @objc private func mainButtonTapped() {
        mockReportView.isExpanded.toggle()
        delegate?.didToggleExpansion(isExpanded: mockReportView.isExpanded)
        updateTitleColor(mockReportView.isExpanded ? .black : .primaryOrange)
    }
    
    override func configure(with item: ReportDetailItem) {
        super.configure(with: item)
        let attributedText = NSAttributedString.styled(
            text: "신고 유형을 선택해주세요",
            style: .body3
        )
        titleLabel.attributedText = attributedText
    }
}
