//
//  MainContentsItem.swift
//  saftyReport
//
//  Created by 김희은 on 11/23/24.
//

import UIKit

enum MainContentsItem {
    static let mainSectionTitle = ["올해 나의 신고", "주요 처리 사례"]
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _ environment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            switch sectionNumber {
            case 0:
                section = createMyReportSection()
            case 1:
                section = createFinishedReportSection()
            default: return nil
            }
            return section
        }
    }

    static func createMyReportSection() -> NSCollectionLayoutSection {
        let item1Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item1 = NSCollectionLayoutItem(layoutSize: item1Size)
        
        let group1Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45))
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: group1Size, subitems: [item1, item1])
        
        group1.interItemSpacing = .fixed(10)
        group1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
        
        let item2Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item2 = NSCollectionLayoutItem(layoutSize: item2Size)
        
        let group2Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55))
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: group2Size, subitems: [item2])
        
        group2.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0)
        let containerGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.639)
                )
        let containerGroup =  NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [group1, group2])

        let section = NSCollectionLayoutSection(group: containerGroup)
        
        section.boundarySupplementaryItems = [createSectionHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 24, trailing: 0)
        
        return section
    }
      
    static func createFinishedReportSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.209))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [createSectionHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.03)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return sectionHeader
    }
}
