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
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: MainContentsItem.createLayout()).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.clipsToBounds = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray1
        
        setUI()
        setLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
                    MyReportCollectionViewCell.self,
                    forCellWithReuseIdentifier: MyReportCollectionViewCell.cellIdentifier
                )
        collectionView.register(
                    MyReportBannerCollectionViewCell.self,
                    forCellWithReuseIdentifier: MyReportBannerCollectionViewCell.cellIdentifier
                )
        collectionView.register(FinishedReportEXCollectionViewCell.self, forCellWithReuseIdentifier: FinishedReportEXCollectionViewCell.cellIdentifier)
        
        collectionView.register(MainContentsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainContentsSectionHeader.identifier
        )
        
        setUpNavigationBar()
    }
    
    private func setUI() {
        self.view.addSubviews(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default :
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.item < 2 {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MyReportCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? MyReportCollectionViewCell else {
                    return UICollectionViewCell(frame: .zero)
                }
                cell.configure(with: indexPath.item)
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MyReportBannerCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as? MyReportBannerCollectionViewCell else {
                    return UICollectionViewCell(frame: .zero)
                }
                return cell
            }
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinishedReportEXCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? FinishedReportEXCollectionViewCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? MyReportCollectionViewCell else {
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
        if indexPath.section == 0 {
            header.configure(with: .myReport)
        } else if indexPath.section == 1 {
            header.configure(with: .finishedReport)
        }
        
        return header
    }
}

#Preview {
    MainViewController()
}
