//
//  GalleryViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class GalleryViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    
    private let usingButtoncontainerView = UIView().then {
        $0.backgroundColor = .gray1
        CustomShadow.shared.applyShadow(to: $0.layer, width: 0, height: 4)
    }
    
    private lazy var usingButton = UIButton().then {
        $0.setAttributedTitle(NSAttributedString.styled(text: "사용", style: .heading1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.setTitleColor(.gray1, for: .normal)
        $0.backgroundColor = .primaryOrange
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(usingButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setupCollectionView()
    }
    
    private func setUI() {
        self.view.addSubviews(collectionView, usingButtoncontainerView)
        usingButtoncontainerView.addSubview(usingButton)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        usingButtoncontainerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        usingButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(8)
            $0.height.equalTo(44)
        }
        
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = createSection()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MediaSelectCell.self,
                                forCellWithReuseIdentifier: MediaSelectCell.cellIdentifier)
        collectionView.register(WarningCell.self,
                                forCellWithReuseIdentifier: WarningCell.cellIdentifier)
        collectionView.register(ContentsCell.self,
                                forCellWithReuseIdentifier: ContentsCell.cellIdentifier)
        collectionView.register(GalleryContentsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: GalleryContentsSectionHeader.identifier
        )
    }
    
    private func createSection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let sectionType = GallerySectionType(rawValue: sectionIndex) else { return nil }
            
            switch sectionType {
            case .mediaSelect:
                return self?.createMediaSelectSection()
            case .warning:
                return self?.createWarningSection()
            case .contents1:
                return self?.createContentsSection()
            case .contents2:
                return self?.createContentsSection()
            }
            
        }
        
        return layout
    }
    
    private func createMediaSelectSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createWarningSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(74)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        return NSCollectionLayoutSection(group: group)
    }
    
    private func createContentsSection() -> NSCollectionLayoutSection {
        // 아이템 크기 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(110),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 3)
        
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(110)
        )
        let nestedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: nestedGroupSize,
            subitems: [item]
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(223)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [nestedGroup, nestedGroup]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        section.boundarySupplementaryItems = [self.createSectionHeader()] // 헤더 추가
                
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30) // 헤더의 높이를 설정
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return sectionHeader
    }

    @objc private func usingButtonTapped() {
        print("사용 버튼이 눌렸습니다.")
    }
    
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: GalleryContentsSectionHeader.identifier,
                  for: indexPath
              ) as? GalleryContentsSectionHeader else {
            return UICollectionReusableView()
        }
        if indexPath.section == 2 {
            let sectionTitles = "2024년 11월 14일"
            header.configure(with: sectionTitles)
        } else if indexPath.section == 3{
            let sectionTitles = "2024년 11월 13일"
            header.configure(with: sectionTitles)
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = GalleryDetailViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 6
        case 3:
            return 6
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MediaSelectCell.cellIdentifier,
                for: indexPath
            ) as? MediaSelectCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WarningCell.cellIdentifier,
                for: indexPath
            ) as? WarningCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentsCell.cellIdentifier,
                for: indexPath
            ) as? ContentsCell else {
                return UICollectionViewCell(frame: .zero)
            }
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentsCell.cellIdentifier,
                for: indexPath
            ) as? ContentsCell else {
                return UICollectionViewCell(frame: .zero)
            }
            
            return cell
        }
    }
    
}
