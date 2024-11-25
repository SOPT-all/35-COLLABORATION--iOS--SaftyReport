//
//  ReportDetailViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

class ReportDetailViewController: UIViewController {
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        CustomShadow.shared.applyShadow(to: $0.layer, width: 0, height: 4)
    }
    
    private let submitButton = UIButton().then {
        $0.setTitle("제출", for: .normal)
        $0.backgroundColor = .primaryOrange
        $0.layer.cornerRadius = 8
    }
    
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
            placeholder: nil,
            showInfoIcon: false
        ),
        ReportDetailItem(
            section: .photo,
            title: "사진",
            isRequired: true,
            placeholder: "사진을 추가해주세요",
            showInfoIcon: true
        ),
        ReportDetailItem(
            section: .location,
            title: "발생지역",
            isRequired: true,
            placeholder: "지역을 입력해주세요",
            showInfoIcon: true
        ),
        ReportDetailItem(
            section: .content,
            title: "내용",
            isRequired: true,
            placeholder: "내용을 입력해주세요",
            showInfoIcon: true
        ),
        ReportDetailItem(
            section: .phone,
            title: "휴대전화",
            isRequired: true,
            placeholder: "전화번호를 입력해주세요",
            showInfoIcon: false
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupSubmitButton()
        configureDataSource()
        applySnapshot()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryOrange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        
        let customNavigationItem = CustomNavigationItem()
        customNavigationItem.setUpNavigationBar(for: .back)
        navigationItem.backBarButtonItem = customNavigationItem.backBarButtonItem
        navigationItem.title = "신고하기"
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubviews(collectionView, containerView)
        collectionView.isScrollEnabled = false
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top)
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
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.1)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 9,
                    trailing: 0
                )
                return section
            }
            
            // 나머지 섹션들의 아이템 사이즈
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)  // 변경
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.18)  // 전체 높이의 18%
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 6,
                leading: 18,
                bottom: 12,
                trailing: 18
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
    
    private func setupSubmitButton() {
        containerView.addSubview(submitButton)
        
        containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(84)
        }
        
        submitButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
        submitButton.addTarget(
            self,
            action: #selector(submitButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func submitButtonTapped() {
        print("제출 버튼이 눌렸습니다.")
    }
}

#Preview {
    let navigationController = UINavigationController(rootViewController: ReportDetailViewController())
    return navigationController
}
