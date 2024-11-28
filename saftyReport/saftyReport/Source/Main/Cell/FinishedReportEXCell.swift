//
//  FinishedReportEXCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class FinishedReportEXCell: UICollectionViewCell {
    let cellIdentifier = "FinishedReportEXCell"
    
    let stackViewList = [1, 2]
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
    
    lazy var pageControl = UIPageControl().then {
        $0.isUserInteractionEnabled = false // 터치 불가
        
        $0.numberOfPages = stackViewList.count
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .gray13
        $0.pageIndicatorTintColor = .gray3
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
        let dotImage = UIImage(named: "Ellipse5x5")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 5)
        )
        $0.preferredIndicatorImage = dotImage
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
        self.addSubviews(stackView, pageControl)
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
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(stackView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(15)
        }
    }
}

extension FinishedReportEXCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / stackView.frame.width)
        pageControl.currentPage = page
    }
}
