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

protocol ReportTypeCellDelegate: AnyObject {
    func didToggleExpansion(isExpanded: Bool)
}

class ReportDetailViewController: UIViewController {
    
    private var isInitialState = true
    private var isOverlayVisible = true
    
    private let overlayView = UIView().then {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        $0.isUserInteractionEnabled = false
    }
    
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
    private var dataSource: UICollectionViewDiffableDataSource<ReportDetailSection, ReportDetailItem>!
    
    private let items: [ReportDetailItem] = [
        ReportDetailItem(
            section: .reportType,
            title: "신고 유형을 선택해주세요",
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
        setupOverlayView()
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
        view.addSubview(collectionView)
        view.addSubview(containerView)
        
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
    
    private func setupOverlayView() {
        view.addSubview(overlayView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self,
                  let locationCell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: 1)) else { return }
            
            let cellFrameInView = self.collectionView.convert(locationCell.frame, to: self.view)
            
            self.overlayView.snp.remakeConstraints {
                $0.top.equalTo(cellFrameInView.minY)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            self.view.layoutIfNeeded()
        }
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
    
    // MARK: - CollectionView Layout
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
                return makeSection(height: totalTopHeight * 0.2, insets: .zero)
            case .photo:
                return makeSection(
                    height: usableHeight * 0.2,
                    insets: .init(top: sectionSpacing + 12, leading: 20, bottom: 0, trailing: 20)
                )
            case .location:
                return makeSection(
                    height: availableHeight * 0.15,
                    insets: .init(top: sectionSpacing, leading: 20, bottom: 0, trailing: 20)
                )
            case .content:
                return makeSection(
                    height: availableHeight * 0.35,
                    insets: .init(top: 0, leading: 20, bottom: 0, trailing: 20)
                )
            case .phone:
                return makeSection(
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
        dataSource = UICollectionViewDiffableDataSource<ReportDetailSection, ReportDetailItem>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return UICollectionViewCell() }
            
            guard let section = ReportDetailSection(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
            switch section {
            case .reportType:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ReportTypeCell.reuseIdentifier,
                    for: indexPath
                ) as! ReportTypeCell
                cell.configure(with: item)
                cell.delegate = self
                
                if self.isInitialState {
                    DispatchQueue.main.async {
                        cell.updateTitleColor(.primaryOrange)
                    }
                }
                return cell
                
            case .photo:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PhotoCell.reuseIdentifier,
                    for: indexPath
                ) as! PhotoCell
                cell.configure(with: item)
                return cell
                
            case .location:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LocationCell.reuseIdentifier,
                    for: indexPath
                ) as! LocationCell
                cell.configure(with: item)
                cell.delegate = self
                return cell
                
            case .content:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ContentCell.reuseIdentifier,
                    for: indexPath
                ) as! ContentCell
                cell.configure(with: item)
                return cell
                
            case .phone:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PhoneCell.reuseIdentifier,
                    for: indexPath
                ) as! PhoneCell
                cell.configure(with: item)
                return cell
            }
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
}

// MARK: - ReportTypeCellDelegate
extension ReportDetailViewController: ReportTypeCellDelegate {
    func didToggleExpansion(isExpanded: Bool) {
        if isInitialState {
            UIView.animate(withDuration: 0.3) {
                self.overlayView.alpha = 0.0
            } completion: { _ in
                self.isOverlayVisible = false
            }
            isInitialState = false
        }
        
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? ReportTypeCell {
            let newColor: UIColor = self.isOverlayVisible || isExpanded ? .primaryOrange : .black
            cell.updateTitleColor(newColor)
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
    }
}

// MARK: - LocationCellDelegate
extension ReportDetailViewController: LocationCellDelegate {
    func locationIconTapped() {
        let reportAddressVC = ReportAddressViewController()
        navigationController?.pushViewController(reportAddressVC, animated: true)
    }
}

// MARK: - Submit Action
extension ReportDetailViewController {
    @objc private func submitButtonTapped() {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            showAlert(message: NetworkError.invalidURL.errorMessage)
            return
        }
        
        let endPoint = "/api/v1/report"
        let fullURL = baseURL + endPoint
        
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
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "userId": "1"
        ]
        
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
