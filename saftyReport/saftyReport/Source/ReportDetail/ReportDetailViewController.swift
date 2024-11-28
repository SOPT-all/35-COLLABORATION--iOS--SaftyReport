//
//  ReportDetailViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then
import Alamofire

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
        navigationItem.backBarButtonItem?.tintColor = .gray1
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
        //  1: URL 주소 생성
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            showAlert(message: NetworkError.invalidURL.errorMessage)
            return
        }
        
        let endPoint = "/api/v1/report"
        let fullURL = baseURL + endPoint
        
        //  2: 전송할 데이터 준비 (원래는 내부 내용이 들어가야하는데 여기서는 목데이터로)
        let reportRequest = ReportRequest(
            photoList: [
                PhotoRequest(photoId: 1, photoUrl: "www.example1.com"),
                PhotoRequest(photoId: 2, photoUrl: "www.example2.com")
            ],
            address: "사랑시 고백구 행복동",
            content: "널 너무나 많이 사랑한죄",
            phoneNumber: "010-2998-0867",
            category: "PARKING"
        )
        
        //  3: HTTP 헤더 설정
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "userId": "1"
        ]
        
        //  4: 네트워크 요청 보내기
        AF.request(
            fullURL,
            method: .post,
            parameters: reportRequest,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: ReportResponse.self) { [weak self] response in
            switch response.result {
            case .success(let reportResponse):
                if reportResponse.status == 201 {
                    self?.showAlert(message: "신고가 성공적으로 접수되었습니다") {
                        self?.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self?.showAlert(message: reportResponse.message ?? NetworkError.serverError.errorMessage)
                }
                
            case .failure(_):
                // 이미 정의된 NetworkError의 에러 메시지 사용
                if let data = response.data {
                    self?.showAlert(message: NetworkError.decodingError.errorMessage)
                } else if response.response == nil {
                    self?.showAlert(message: NetworkError.networkError(response.error!).errorMessage)
                } else {
                    self?.showAlert(message: NetworkError.serverError.errorMessage)
                }
            }
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
