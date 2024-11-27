//
//  MainViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    let customNavigationItem = CustomNavigationItem(title: "홈") // 반드시 타이틀 설정
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: MainContentsItemLayout.createLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.clipsToBounds = false
    }
    
    private lazy var floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "icn_cross_i_normal_white_16px"), for: .normal)
        $0.setTitle("신고하기", for: .normal)
        $0.titleLabel?.font = TextStyle.body3.font
        $0.setTitleColor(.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .primaryOrange
        $0.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray1
        
        setUI()
        setLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
                    MyReportCell.self,
                    forCellWithReuseIdentifier: MyReportCell.cellIdentifier
                )
        collectionView.register(
                    MyReportBannerCell.self,
                    forCellWithReuseIdentifier: MyReportBannerCell.cellIdentifier
                )
        collectionView.register(
            FinishedReportEXCell.self,
            forCellWithReuseIdentifier: FinishedReportEXCell.cellIdentifier
        )
        collectionView.register(
            MainContentsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainContentsSectionHeader.identifier
        )
        
        setUpNavigationBar()
    }
    
    private func setUI() {
        self.view.addSubviews(collectionView, floatingButton)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        floatingButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(14)
            $0.height.equalTo(40)
            $0.width.equalTo(104)
            $0.trailing.equalToSuperview().inset(13)
        }
    }
    
    private func setUpNavigationBar() {
        navigationController?.setUpNavigationBarColor()
        customNavigationItem.setUpNavigationBar(for: .leftRight)
        customNavigationItem.setUpTitle(title: "")

        navigationItem.title = customNavigationItem.title
        navigationItem.leftBarButtonItem = customNavigationItem.leftBarButtonItem
        navigationItem.rightBarButtonItem = customNavigationItem.rightBarButtonItem
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportCell.cellIdentifier,
                for: indexPath
            ) as? MyReportCell else {
                return UICollectionViewCell(frame: .zero)
            }
            cell.configure(with: indexPath.item)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportBannerCell.cellIdentifier,
                for: indexPath
            ) as? MyReportBannerCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinishedReportEXCell.cellIdentifier,
                for: indexPath
            ) as? FinishedReportEXCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportCell.cellIdentifier,
                for: indexPath
            ) as? MyReportCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MainContentsSectionHeader.identifier,
                for: indexPath
              ) as? MainContentsSectionHeader else {
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
        case 0:
            header.configure(with: MainHeaderItem(
                section: .myReport,
                title: "올해 나의 신고",
                rightHeaderItem: .mileageLabel))
        case 1:
            header.configure(with: MainHeaderItem(
                section: .banner,
                title: nil,
                rightHeaderItem: nil))
        case 2:
            header.configure(with: MainHeaderItem(
                section: .finishedReport,
                title: "주요 처리 사례",
                rightHeaderItem: .moreButton))
        default :
            break
        }
        return header
    }
}

#Preview {
    MainViewController()
}
