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

actor ReportService {
    static let shared = ReportService()
    private init() {}
    
    private var cachedResponses: [String: ReportResponse] = [:]
    
    func submitReport(_ report: ReportRequest) async throws -> ReportResponse {
        let cacheKey = "\(report.content)-\(report.phoneNumber)"
        
        if let cachedResponse = cachedResponses[cacheKey] {
            return cachedResponse
        }
        
        let url = "\(Environment.baseURL)/api/v1/report"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "userId": "1"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: .post,
                parameters: report,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: ReportResponse.self) { response in
                switch response.result {
                case .success(let reportResponse):
                    self.cachedResponses[cacheKey] = reportResponse
                    continuation.resume(returning: reportResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

class ReportDetailViewController: UIViewController {
    private var contentText: String = ""
    private var phoneNumber: String = ""
    
    private var isInitialState = true
    private var isOverlayVisible = true
    
    private var alertContentViewCache: [String: UIView] = [:]
    
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
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("제출", for: .normal)
        button.backgroundColor = .primaryOrange
        button.layer.cornerRadius = 8
        button.addAction(
            UIAction { [weak self] _ in
                Task { @MainActor in
                    await self?.handleSubmit()
                }
            },
            for: .touchUpInside
        )
        return button
    }()
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ReportDetailSection, ReportDetailItem>!
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupOverlayView()
        setupSubmitButton()
        setupLoadingIndicator()
        configureDataSource()
        applySnapshot()
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func handleSubmit() async {
        do {
            async let alertResult = showSubmitConfirmationAlert()
            async let prepareData = prepareSubmitData()
            
            let (shouldSubmit, reportRequest) = await (alertResult, prepareData)
            
            guard shouldSubmit else { return }
            
            loadingIndicator.startAnimating()
            let response = try await ReportService.shared.submitReport(reportRequest)
            loadingIndicator.stopAnimating()
            
            await MainActor.run {
                handleResponse(response)
            }
            
        } catch {
            loadingIndicator.stopAnimating()
            await handleError(error)
        }
    }
    
    private func prepareSubmitData() async -> ReportRequest {
        ReportRequest(
            photoList: [
                PhotoRequest(photoId: 1, photoUrl: "www.example1.com"),
                PhotoRequest(photoId: 2, photoUrl: "www.example2.com")
            ],
            address: "서울시 마포구",
            content: contentText,
            phoneNumber: phoneNumber,
            category: "PARKING"
        )
    }
    
    private func handleResponse(_ response: ReportResponse) {
        if response.status == 201 {
            Task {
                await showSuccessAlert()
            }
        } else {
            Task {
                await showErrorAlert(message: response.message ?? "오류가 발생했습니다")
            }
        }
    }
    
    private func handleError(_ error: Error) async {
        await showErrorAlert(message: "네트워크 오류가 발생했습니다")
    }
    
    private func showSubmitConfirmationAlert() async -> Bool {
        await withCheckedContinuation { continuation in
            let alertVC = BaseTwoButtonAlertViewController()
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.setAlert("알림", createAlertContentView(text: "신고 내용을 제출하시겠습니까?"))
            
            alertVC.alertView.confirmButton.addAction(
                UIAction { [weak alertVC] _ in
                    alertVC?.dismiss(animated: false) {
                        continuation.resume(returning: true)
                    }
                },
                for: .touchUpInside
            )
            
            alertVC.alertView.cancelButton.addAction(
                UIAction { [weak alertVC] _ in
                    alertVC?.dismiss(animated: false) {
                        continuation.resume(returning: false)
                    }
                },
                for: .touchUpInside
            )
            
            present(alertVC, animated: false)
        }
    }
    
    private func showSuccessAlert() async {
        await withCheckedContinuation { continuation in
            let alertVC = BaseTwoButtonAlertViewController()
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.setAlert("알림", createAlertContentView(text: "신고가 성공적으로 접수되었습니다"))
            
            alertVC.alertView.cancelButton.setTitle("닫기", for: .normal)
            alertVC.alertView.confirmButton.setTitle("홈으로", for: .normal)
            
            alertVC.alertView.cancelButton.addAction(
                UIAction { [weak alertVC] _ in
                    alertVC?.dismiss(animated: false) {
                        continuation.resume()
                    }
                },
                for: .touchUpInside
            )
            
            alertVC.alertView.confirmButton.addAction(
                UIAction { [weak self, weak alertVC] _ in
                    alertVC?.dismiss(animated: false) {
                        self?.navigateToHome()
                        continuation.resume()
                    }
                },
                for: .touchUpInside
            )
            
            present(alertVC, animated: false)
        }
    }
    
    private func showErrorAlert(message: String) async {
        await withCheckedContinuation { continuation in
            let alertVC = BaseTwoButtonAlertViewController()
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.setAlert("알림", createAlertContentView(text: message))
            
            alertVC.alertView.cancelButton.isHidden = true
            alertVC.alertView.confirmButton.addAction(
                UIAction { [weak alertVC] _ in
                    alertVC?.dismiss(animated: false) {
                        continuation.resume()
                    }
                },
                for: .touchUpInside
            )
            
            present(alertVC, animated: false)
        }
    }
    
    private func navigateToHome() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarViewController = CustomTabBarController()
        tabBarViewController.setNavViewControllers()
        
        UIView.transition(with: window,
                         duration: 0.2,
                         options: .transitionCrossDissolve,
                         animations: {
            window.rootViewController = tabBarViewController
        })
    }
    
    private func createAlertContentView(text: String) -> UIView {
        if let cachedView = alertContentViewCache[text] {
            return cachedView
        }
        
        let contentView = UIView()
        let textLabel = UILabel().then {
            $0.attributedText = .styled(text: text, style: .body3)
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.textColor = .gray13
        }
        
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(25)
        }
        
        alertContentViewCache[text] = contentView
        return contentView
    }
}

extension ReportDetailViewController: ReportTypeCellDelegate {
    func didToggleExpansion(isExpanded: Bool) {
        if isInitialState {
            UIView.animate(withDuration: 0.2) {
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

extension ReportDetailViewController {
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
       
       registerCells()
   }
   
   private func registerCells() {
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
           
           let totalTopHeight = (navigationController?.navigationBar.frame.height ?? 0) +
                              (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
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
                   Task { @MainActor in
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
               cell.delegate = self
               return cell
               
           case .phone:
               let cell = collectionView.dequeueReusableCell(
                   withReuseIdentifier: PhoneCell.reuseIdentifier,
                   for: indexPath
               ) as! PhoneCell
               cell.configure(with: item)
               cell.delegate = self
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

extension ReportDetailViewController {
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
}

// MARK: - Navigation & Delegate Extensions
extension ReportDetailViewController: LocationCellDelegate {
   func locationIconTapped() {
       let reportAddressVC = ReportAddressViewController()
       reportAddressVC.delegate = self
       navigationController?.pushViewController(reportAddressVC, animated: true)
   }
}

extension ReportDetailViewController: ReportAddressDelegate {
   func didSelectAddress(_ address: String) {
       if let indexPath = IndexPath(item: 0, section: 2) as? IndexPath,
          let cell = collectionView.cellForItem(at: indexPath) as? LocationCell {
           cell.updateLocationText(address)
       }
   }
}

extension ReportDetailViewController: ContentCellDelegate, PhoneCellDelegate {
   func contentDidChange(_ text: String) {
       self.contentText = text
   }
   
   func phoneNumberDidChange(_ number: String) {
       self.phoneNumber = number
   }
}

extension ReportDetailViewController {
    private func setupOverlayView() {
        view.addSubview(overlayView)
        
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            guard let locationCell = collectionView.cellForItem(
                at: IndexPath(
                    item: 0,
                    section: 1
                )
            ) else {
                return
            }
            let cellFrameInView = collectionView.convert(locationCell.frame, to: view)
            
            overlayView.snp.remakeConstraints {
                $0.top.equalTo(cellFrameInView.minY)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            view.layoutIfNeeded()
        }
    }
    
    private func setupSubmitButton() {
        containerView.addSubview(submitButton)
        
        submitButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
    }
}

#Preview {
   let navigationController = UINavigationController(rootViewController: ReportDetailViewController())
   return navigationController
}
