//
//  MainViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    let customNavigationItem = CustomNavigationItem(title: "홈") // 반드시 타이틀 설정
    private var isToggled = false
    
    private lazy var floatingButton = UIButton().then {
        $0.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    private lazy var allStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alpha = 0.0
        $0.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    private lazy var categoryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    let safetyButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    let parkingButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    let reportButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    let lifeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    let allCategoryButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    let cameraButton = UIButton().then {
        $0.setImage(UIImage(systemName: "shield"), for: .normal)
        $0.setTitle("안전", for: .normal)
    }
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: MainContentsItemLayout.createLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.clipsToBounds = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray1
        
        setUI()
        setLayout()
        updateFloaingButtonUI()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            MyReportCell.self,
            forCellWithReuseIdentifier: MyReportCell.cellIdentifier
        )
        collectionView.register(
            MyReportBannerCell.self,
            forCellWithReuseIdentifier: MyReportBannerCell.cellIdentifier
        )
        collectionView.register(
            FinishedReportEXCell.self,
            forCellWithReuseIdentifier: FinishedReportEXCell.cellIdentifier
        )
        collectionView.register(
            MainContentsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainContentsSectionHeader.identifier
        )
        
        setUpNavigationBar()
    }
    
    private func setUI() {
        self.view.addSubviews(collectionView, floatingButton, allStackView)
        allStackView.addArrangedSubviews(categoryStackView, stackView)
        categoryStackView.addArrangedSubviews(safetyButton, parkingButton, reportButton, lifeButton)
        stackView.addArrangedSubviews(allCategoryButton, cameraButton)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        floatingButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(14)
            $0.height.equalTo(40)
            $0.width.equalTo(104)
            $0.trailing.equalToSuperview().inset(13)
        }
        allStackView.snp.makeConstraints {
            $0.trailing.equalTo(floatingButton.snp.trailing)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-16)
        }
        categoryStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    
    // MARK: - Floating Button and Animation
    
    @objc private func floatingButtonTapped(_ sender: UIButton) {
        isToggled.toggle()
        
        popStackView()
        updateAnimation()
        updateFloaingButtonUI()
    }
    
    private func updateAnimation() {
        let newWidth: CGFloat = isToggled ? 40 : 104
        let newAngle: CGFloat = isToggled ? CGFloat.pi / 4 : 0
        
        floatingButton.snp.updateConstraints {
            $0.width.equalTo(newWidth)
        }

        UIView.animate(withDuration: 0.15) {
            self.view.layoutIfNeeded() // 레이아웃 업데이트를 애니메이션으로 적용
            self.floatingButton.transform = CGAffineTransform(rotationAngle: newAngle) // 45도 회전
        }
    }
    
    private func popStackView() {
        if isToggled {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: {
                    self.allStackView.alpha = 1.0
                    self.allStackView.transform = CGAffineTransform.identity
                }
            )
        } else {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: {
                    self.allStackView.alpha = 0.0
                    self.allStackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }
            )
        }
    }
    
    private func updateFloaingButtonUI() {
        let image = UIImage(named: "icn_cross_i_normal_white_16px")?.withRenderingMode(.alwaysTemplate)
        floatingButton.setImage(image, for: .normal)
        
        if isToggled {
            floatingButton.setTitle("", for: .normal)
            floatingButton.tintColor = .gray13
            floatingButton.backgroundColor = .gray1
            floatingButton.layer.cornerRadius = 20
        } else {
            floatingButton.setTitle("신고하기", for: .normal)
            floatingButton.titleLabel?.font = TextStyle.body3.font
            floatingButton.tintColor = .gray1
            floatingButton.backgroundColor = .primaryOrange
            floatingButton.layer.cornerRadius = 20
        }
    }
    
    
    // MARK: - Navigation Bar
    private func setUpNavigationBar() {
        navigationController?.setUpNavigationBarColor()
        customNavigationItem.setUpNavigationBar(for: .leftRight)
        customNavigationItem.setUpTitle(title: "")

        navigationItem.title = customNavigationItem.title
        navigationItem.leftBarButtonItem = customNavigationItem.leftBarButtonItem
        navigationItem.rightBarButtonItem = customNavigationItem.rightBarButtonItem
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 1
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportCell.cellIdentifier,
                for: indexPath
            ) as? MyReportCell else {
                return UICollectionViewCell(frame: .zero)
            }
            cell.configure(with: indexPath.item)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportBannerCell.cellIdentifier,
                for: indexPath
            ) as? MyReportBannerCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FinishedReportEXCell.cellIdentifier,
                for: indexPath
            ) as? FinishedReportEXCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportCell.cellIdentifier,
                for: indexPath
            ) as? MyReportCell else {
                return UICollectionViewCell(frame: .zero)
            }
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MainContentsSectionHeader.identifier,
                for: indexPath
              ) as? MainContentsSectionHeader else {
            return UICollectionReusableView()
        }
        
        switch indexPath.section {
        case 0:
            header.configure(with: MainHeaderItem(
                section: .myReport,
                title: "올해 나의 신고",
                rightHeaderItem: .mileageLabel))
        case 1:
            header.configure(with: MainHeaderItem(
                section: .banner,
                title: nil,
                rightHeaderItem: nil))
        case 2:
            header.configure(with: MainHeaderItem(
                section: .finishedReport,
                title: "주요 처리 사례",
                rightHeaderItem: .moreButton))
        default :
            break
        }
        return header
    }
}

#Preview {
    MainViewController()
}
