//
//  ReportCategoryView.swift
//  saftyReport
//
//  Created by 김유림 on 11/26/24.
//

import UIKit

class ReportCategoryView: UIView {
    
    // MARK: - Properties
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 68
    }
    
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .gray1
    }
    
    private func setHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
