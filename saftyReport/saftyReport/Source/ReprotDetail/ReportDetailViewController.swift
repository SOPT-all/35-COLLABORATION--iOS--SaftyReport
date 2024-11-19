//
//  ReportDetailViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

struct ReportDetailItem: Hashable {
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
        ReportDetailItem
    >!
    
    private let items: [ReportDetailItem] = [
        ReportDetailItem(
            section: .reportType,
            title: "",
            isRequired: false,
            placeholder: nil
        ),
        ReportDetailItem(
            section: .photo,
            title: "사진",
            isRequired: true,
            placeholder: "사진을 추가해주세요"
        ),
        ReportDetailItem(
            section: .location,
            title: "발생지역",
            isRequired: true,
            placeholder: "지역을 입력해주세요"
        ),
        ReportDetailItem(
            section: .content,
            title: "내용",
            isRequired: true,
            placeholder: "내용을 입력해주세요"
        ),
        ReportDetailItem(
            section: .phone,
            title: "휴대전화",
            isRequired: true,
            placeholder: "010-2998-0867"
        )
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
        
        [(ReportTypeCell.self, ReportTypeCell.reuseIdentifier),
         (PhotoCell.self, PhotoCell.reuseIdentifier),
         (LocationCell.self, LocationCell.reuseIdentifier),
         (ContentCell.self, ContentCell.reuseIdentifier),
         (PhoneCell.self, PhoneCell.reuseIdentifier)].forEach { cellClass, identifier in
            collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = ReportDetailSection(rawValue: sectionIndex)
            
            if section == .reportType {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(48)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(48)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 16,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
                return section
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [NSCollectionLayoutItem(layoutSize: groupSize)]
            )
            
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 8,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
            return layoutSection
        }
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ReportDetailSection, ReportDetailItem>(collectionView: collectionView) { collectionView, indexPath, item in
            return self.cellForItem(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }
    
    private func cellForItem(collectionView: UICollectionView, indexPath: IndexPath, item: ReportDetailItem) -> UICollectionViewCell {
        guard let section = ReportDetailSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        let reuseIdentifier: String
        
        switch section {
        case .reportType:
            reuseIdentifier = ReportTypeCell.reuseIdentifier
        case .photo:
            reuseIdentifier = PhotoCell.reuseIdentifier
        case .location:
            reuseIdentifier = LocationCell.reuseIdentifier
        case .content:
            reuseIdentifier = ContentCell.reuseIdentifier
        case .phone:
            reuseIdentifier = PhoneCell.reuseIdentifier
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        if let configurableCell = cell as? ConfigurableCell {
            configurableCell.configure(with: item)
        }
        return cell
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ReportDetailSection, ReportDetailItem>()
        ReportDetailSection.allCases.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(items.filter { $0.section == section }, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

#Preview {
    ReportDetailViewController()
}
