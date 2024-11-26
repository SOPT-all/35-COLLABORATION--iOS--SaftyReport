//
//  ReportCategoryExpandedTableViewCell.swift
//  saftyReport
//
//  Created by 김유림 on 11/27/24.
//

import UIKit

class ReportCategoryExpandedTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let descriptionView = UIView().then {
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 10
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .orange
        
        contentView.addSubview(descriptionView)
        
        descriptionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
