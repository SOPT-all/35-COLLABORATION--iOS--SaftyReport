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
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        CustomShadow.shared.applyShadow(to: $0.layer, width: 0, height: -4)
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
        collectionView.isScrollEnabled = false
        view.addSubviews(collectionView, containerView)
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            
            let totalTopHeight = (navigationController?.navigationBar.frame.height ?? 0) + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
            let availableHeight = view.frame.height - totalTopHeight - 84
            
            let sectionSpacing: CGFloat = 28
            let totalSpacing = sectionSpacing * 4
            let usableHeight = availableHeight - totalSpacing
            
            let section = ReportDetailSection(rawValue: sectionIndex)
            switch section {
            case .reportType:
                return makeSection(
                    height: totalTopHeight * 0.2,
                    insets: .zero
                )
            case .photo:
                return makeSection(
                    height: usableHeight * 0.2,
                    insets: .init(top: sectionSpacing + 12, leading: 20, bottom: 0, trailing: 20)
                )
                
            case .location:
                return self.makeSection(
                    height: availableHeight * 0.15,
                    insets: .init(top: sectionSpacing, leading: 20, bottom: 0, trailing: 20)
                )
                
            case .content:
                return self.makeSection(
                    height: availableHeight * 0.35,
                    insets: .init(top: 0, leading: 20, bottom: 0, trailing: 20)
                )
                
            case .phone:
                return self.makeSection(
                    height: availableHeight * 0.15,
                    insets: .init(top: 0, leading: 20, bottom: 0, trailing: 20)
                )
                
            case .none:
                return nil
            }
        }
        return layout
    }
    
    private func makeSection(height: CGFloat, insets: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: itemSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = insets
        return section
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ReportDetailSection, ReportDetailItem>(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return UICollectionViewCell() }
            
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
            
            if let locationCell = cell as? LocationCell {
                locationCell.delegate = self
            }
            
            if let configurableCell = cell as? ConfigurableCell {
                configurableCell.configure(with: item)
            }
            
            return cell
        }
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
}

extension ReportDetailViewController: LocationCellDelegate {
    func locationIconTapped() {
        let reportAddressVC = ReportAddressViewController()
        navigationController?.pushViewController(reportAddressVC, animated: true)
    }
}

extension ReportDetailViewController {
    @objc private func submitButtonTapped() {
        // 1. URL 생성
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: baseURL + "/api/v1/report") else {
            showAlert(message: NetworkError.invalidURL.errorMessage)
            return
        }
        
        // 2. Request 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("1", forHTTPHeaderField: "userId")
        
        // 3. Request Body 생성
        let reportRequest = ReportRequest(
            photoList: [
                PhotoRequest(photoId: 1, photoUrl: "www.example1.com"),
                PhotoRequest(photoId: 2, photoUrl: "www.example2.com")
            ],
            address: "서울시 강남구",
            content: "신고 내용 테스트",
            phoneNumber: "010-1234-5678",
            category: "PARKING"
        )
        
        // 4. Request Body를 JSON으로 변환
        do {
            let jsonData = try JSONEncoder().encode(reportRequest)
            request.httpBody = jsonData
        } catch {
            showAlert(message: NetworkError.invalidRequest.errorMessage)
            return
        }
        
        // 5. 네트워크 요청 보내기
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.showAlert(message: NetworkError.networkError(error).errorMessage)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        self?.showAlert(message: NetworkError.invalidResponse.errorMessage)
                        return
                    }
                    
                    guard let data = data else {
                        self?.showAlert(message: NetworkError.invalidResponse.errorMessage)
                        return
                    }
                    
                    do {
                        let response = try JSONDecoder().decode(ReportResponse.self, from: data)
                        
                        if response.status == 201 {
                            self?.showAlert(message: "신고가 성공적으로 접수되었습니다") {
                                self?.navigationController?.popViewController(animated: true)
                            }
                        } else {
                            self?.showAlert(message: response.message ?? NetworkError.serverError.errorMessage)
                        }
                    } catch {
                        self?.showAlert(message: NetworkError.decodingError.errorMessage)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


#Preview {
    let navigationController = UINavigationController(rootViewController: ReportDetailViewController())
    return navigationController
}
