//
//  GalleryViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

protocol GalleryViewControllerDelegate: AnyObject {
    func didSelectImages(_ images: [GalleryPhotoList])
}

class GalleryViewController: UIViewController {
    private let networkManager = NetworkManager()
    weak var delegate: GalleryViewControllerDelegate?
    
    private var selectedImages: [GalleryPhotoList] = []
    
    private var firstSectionPhotoList: [GalleryPhotoList] = []
    private var firstSectionCheckedStatus: Set<IndexPath> = []
    
    private var secondSectionPhotoList: [GalleryPhotoList] = []
    private var secondSectionCheckedStatus: Set<IndexPath> = []
    
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
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(usingButtonTapped), for: .touchUpInside)
        $0.backgroundColor = .primaryLight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setupCollectionView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        connectAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
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
    
    private func setupNavigationBar() {
        let customNavigationItem = CustomNavigationItem()
        customNavigationItem.setUpNavigationBar(for: .back)
        navigationItem.backBarButtonItem = customNavigationItem.backBarButtonItem
        navigationItem.backBarButtonItem?.tintColor = .gray1
        navigationItem.title = "안전신문고 갤러리"
    }
    
    @objc private func usingButtonTapped() {
        print("선택된 이미지 개수:", selectedImages.count)
        print("선택된 이미지:", selectedImages)
        delegate?.didSelectImages(selectedImages)
        navigationController?.popViewController(animated: true)
    }
    
    private func connectAPI() {
        DispatchQueue.main.async {
            self.networkManager.photoAPI { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case let .success(list):
                    print("API 성공 - 받아온 데이터:", list)
                    
                    self.firstSectionPhotoList = list.filter({
                        self.formatDateTime($0.createdAt!) == "2024년 10월 26일"
                    })
                    .dropLast()
                    
                    self.secondSectionPhotoList = list.filter({
                        self.formatDateTime($0.createdAt!) == "2024년 11월 26일"
                    })
                    .dropLast()
                    
                    print("필터링된 첫 번째 섹션:", self.firstSectionPhotoList)
                    print("필터링된 두 번째 섹션:", self.secondSectionPhotoList)
                    
                    self.collectionView.reloadData()
                    
                case let .failure(error):
                    print("API 에러:", error.localizedDescription)
                }
            }
        }
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
            let sectionTitles = "2024년 10월 26일"
            header.configure(with: sectionTitles)
        } else if indexPath.section == 3{
            let sectionTitles = "2024년 11월 26일"
            header.configure(with: sectionTitles)
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section >= 2,
              let cell = collectionView.cellForItem(at: indexPath) as? ContentsCell else {
            return
        }
        
        let nextViewController = GalleryDetailViewController()
        nextViewController.isChecked = cell.isChecked
        nextViewController.indexPath = indexPath
        
        nextViewController.checkboxHandler = { [weak self] isChecked, indexPath in
            guard let self = self else { return }
            
            let selectedImage = indexPath.section == 2 ?
                self.firstSectionPhotoList[indexPath.row] :
                self.secondSectionPhotoList[indexPath.row]
            
            self.updateImageSelection(isChecked: isChecked,
                                    image: selectedImage,
                                    at: indexPath)
            
            if let cell = self.collectionView.cellForItem(at: indexPath) as? ContentsCell {
                cell.updateCheckboxState(isChecked)
            }
        }
        
        if indexPath.section == 2 {
            nextViewController.configure(item: firstSectionPhotoList[indexPath.row])
        } else {
            nextViewController.configure(item: secondSectionPhotoList[indexPath.row])
        }
        
        cell.checkbox.addTarget(self,
                              action: #selector(checkboxTapped(_:forEvent:)),
                              for: .touchUpInside)
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func updateUsingButtonState() {
            print("updateUsingButtonState called - selectedImages count:", selectedImages.count)
            let isEnabled = !selectedImages.isEmpty
            
            if isEnabled {
                usingButton.backgroundColor = .primaryOrange
                usingButton.setTitleColor(.gray1, for: .normal)
                usingButton.isEnabled = true
            } else {
                usingButton.backgroundColor = .gray2
                usingButton.setTitleColor(.gray4, for: .normal)
                usingButton.isEnabled = false
            }
            
            print("Button state updated - isEnabled:", isEnabled)
            print("Button background color:", usingButton.backgroundColor ?? "nil")
        }

        private func updateImageSelection(isChecked: Bool, image: GalleryPhotoList, at indexPath: IndexPath) {
            if isChecked {
                if !selectedImages.contains(where: { $0.photoId == image.photoId }) {
                    selectedImages.append(image)
                }
                if indexPath.section == 2 {
                    firstSectionCheckedStatus.insert(indexPath)
                } else {
                    secondSectionCheckedStatus.insert(indexPath)
                }
            } else {
                selectedImages.removeAll { $0.photoId == image.photoId }
                if indexPath.section == 2 {
                    firstSectionCheckedStatus.remove(indexPath)
                } else {
                    secondSectionCheckedStatus.remove(indexPath)
                }
            }
            
            print("이미지 선택 상태 변경 - isChecked:", isChecked)
            print("현재 선택된 이미지 개수:", selectedImages.count)
            
            DispatchQueue.main.async { [weak self] in
                self?.updateUsingButtonState()
                self?.collectionView.reloadData()
            }
        
    }

    @objc private func checkboxTapped(_ sender: UIButton, forEvent event: UIEvent) {
        guard let touch = event.allTouches?.first,
              let point = touch.view?.convert(touch.location(in: touch.view), to: collectionView),
              let indexPath = collectionView.indexPathForItem(at: point),
              let cell = collectionView.cellForItem(at: indexPath) as? ContentsCell else {
            return
        }
        
        let selectedImage = indexPath.section == 2 ?
            firstSectionPhotoList[indexPath.row] :
            secondSectionPhotoList[indexPath.row]
        
        updateImageSelection(isChecked: cell.isChecked,
                            image: selectedImage,
                            at: indexPath)
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
            return firstSectionPhotoList.count
        case 3:
            return secondSectionPhotoList.count
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
                
                let item = firstSectionPhotoList[indexPath.row]
                cell.configure(item: item,
                              isChecked: firstSectionCheckedStatus.contains(indexPath)) { [weak self] isChecked in
                    guard let self = self else { return }
                    
                    self.updateImageSelection(isChecked: isChecked,
                                            image: item,
                                            at: indexPath)
                    self.updateUsingButtonState()
                }
                
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ContentsCell.cellIdentifier,
                    for: indexPath
                ) as? ContentsCell else {
                    return UICollectionViewCell(frame: .zero)
                }
                
                let item = secondSectionPhotoList[indexPath.row]
                cell.configure(item: item,
                              isChecked: secondSectionCheckedStatus.contains(indexPath)) { [weak self] isChecked in
                    guard let self = self else { return }
                    
                    self.updateImageSelection(isChecked: isChecked,
                                            image: item,
                                            at: indexPath)
                    self.updateUsingButtonState() 
                }
                
                return cell
            }
        }
    
}

extension GalleryViewController {
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
            widthDimension: .fractionalWidth(1/3),
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
            trailing: 17
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
}

extension GalleryViewController {
    private func formatDateTime(_ dateTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // 서버에서 받은 날짜 형식
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy년 MM월 dd일" // 원하는 출력 형식
        
        // 입력 문자열을 Date로 변환한 후, 다시 문자열로 변환
        if let date = inputFormatter.date(from: dateTime) {
            return outputFormatter.string(from: date)
        } else {
            print("[Error] Invalid date format: \(dateTime)")
            return dateTime // 변환 실패 시 원본 문자열 반환
        }
    }
}
