//
//  ReprotDetailViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

struct ReprotDetailItem: Hashable {
    let id = UUID()
    let section: ReportDetailSection
    let title: String
    let isRequired: Bool
    let placeholder: String?
}

class ReportDetailViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<
        ReportDetailSection,
        ReprotDetailItem
    >!
    private let items: [ReprotDetailItem] = [
        ReprotDetailItem(section: .photo, title: "사진", isRequired: true, placeholder: "사진을 추가해주세요"),
        ReprotDetailItem(section: .location, title: "발생지역", isRequired: true, placeholder: "지역을 입력해주세요"),
        ReprotDetailItem(section: .content, title: "내용", isRequired: true, placeholder: "내용을 입력해주세요"),
        ReprotDetailItem(section: .phone, title: "휴대전화", isRequired: true, placeholder: "010-2998-0867")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
        applySnapshot()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [(PhotoCell.self, PhotoCell.reuseIdentifier),
         (LocationCell.self, LocationCell.reuseIdentifier),
         (ContentCell.self, ContentCell.reuseIdentifier),
         (PhoneCell.self, PhoneCell.reuseIdentifier)].forEach { cellClass, identifier in
            collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [NSCollectionLayoutItem(layoutSize: groupSize)]
            )
            
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            return layoutSection
        }
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ReportDetailSection, ReprotDetailItem>(collectionView: collectionView) { collectionView, indexPath, item in
            return self.cellForItem(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }
    
    private func cellForItem(collectionView: UICollectionView, indexPath: IndexPath, item: ReprotDetailItem) -> UICollectionViewCell {
        guard let section = ReportDetailSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        let reuseIdentifier: String
        switch section {
        case .photo:
            reuseIdentifier = PhotoCell.reuseIdentifier
        case .location:
            reuseIdentifier = LocationCell.reuseIdentifier
        case .content:
            reuseIdentifier = ContentCell.reuseIdentifier
        case .phone:
            reuseIdentifier = PhoneCell.reuseIdentifier
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let configurableCell = cell as? ConfigurableCell {
            configurableCell.configure(with: item)
        }
        return cell
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ReportDetailSection, ReprotDetailItem>()
        ReportDetailSection.allCases.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(items.filter { $0.section == section }, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

