//
//  GalleryContentsSectionHeader.swift
//  saftyReport
//
//  Created by OneTen on 11/20/24.
//

import UIKit

import SnapKit

class GalleryContentsSectionHeader: UICollectionReusableView {
    static let identifier = "GalleryContentsSectionHeader"
    
    private let dateLabel = UILabel().then {
        $0.attributedText = .styled(text: "임시", style: .body2)
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .gray13
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
        self.addSubview(dateLabel)
    }
    
    private func setLayout(){
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(20)
        }
    }
    
    func configure(with header: String) {
        dateLabel.text = header
    }
}
