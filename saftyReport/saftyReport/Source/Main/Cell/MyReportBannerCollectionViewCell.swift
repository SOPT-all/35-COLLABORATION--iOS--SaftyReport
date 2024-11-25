//
//  MyReportBannerCollectionViewCell.swift
//  saftyReport
//
//  Created by 김희은 on 11/25/24.
//

import UIKit

class MyReportBannerCollectionViewCell: UICollectionViewCell {
    let cellIdentifier: String = "MyReportBannerCollectionViewCell"
    
    let bannerImgList = ["img_promotion_1", "img_promotion_2", "img_promotion_3"]
    
    let leftButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "icn_arrow_left_round_white_24px"), for: .normal)
        $0.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        print(self)
    }
    let rightButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "icn_arrow_right_round_white_24px"), for: .normal)
        $0.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
        $0.footerReferenceSize = .zero
        $0.headerReferenceSize = .zero
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    lazy var pageControl = UIPageControl().then {
        $0.numberOfPages = bannerImgList.count
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .gray1
        $0.pageIndicatorTintColor = .gray1Opacity30
        $0.backgroundColor = .gray13Opacity40
        $0.layer.cornerRadius = 5
        
        let dotImage = UIImage(named: "Ellipse5x5")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 5)
        )
        $0.preferredIndicatorImage = dotImage
        
        $0.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        self.addSubviews(leftButton, rightButton)
    }
    
    private func setLayout() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(59)
            $0.height.equalTo(15)
        }
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
        }
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func scrollToCurrentPage() {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func leftButtonTapped(_ sender: UIButton) {
        pageControl.currentPage -= 1
        scrollToCurrentPage()
    }
    
    @objc private func rightButtonTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        scrollToCurrentPage()
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension MyReportBannerCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / collectionView.frame.width)
        pageControl.currentPage = page
    }
}

extension MyReportBannerCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = bannerImgList.count
        return self.pageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.cellIdentifier, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.configure(image: bannerImgList[indexPath.row])
        return cell
    }
}

extension MyReportBannerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
