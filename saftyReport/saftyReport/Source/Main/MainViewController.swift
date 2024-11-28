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
    private let networkManager = NetworkManager()
    
    var yearReportCount: Int = 0
    var monthReportCount: Int = 0
    var mileage: Int?
    var bannerList: [BannerList] = []
    var bannerListImgUrl: [String] = []
    
    let customNavigationItem = CustomNavigationItem(title: "홈") // 반드시 타이틀 설정
    
    private var isToggled = false
    
    private lazy var floatingButton = UIButton().then {
        $0.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.backgroundColor = .gray1
        $0.alpha = 0.0
        $0.transform = CGAffineTransform.identity
        $0.layer.cornerRadius = 15
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
        
        CustomShadow.shared.applyShadow(to: tableView.layer, width: 5, height: 5)
        
        setUI()
        setLayout()
        setCollectionView()
        setTableView()
        
        updateFloaingButtonUI()
        
        setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connectAPI()
    }
    
    private func setUI() {
        self.view.addSubviews(collectionView, floatingButton, tableView)
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
        tableView.snp.makeConstraints {
            $0.trailing.equalTo(floatingButton.snp.trailing)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-16)
            $0.width.equalTo(175)
            $0.height.equalTo(270)
        }
    }
    
    private func setCollectionView() {
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
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            ButtonTableCell.self,
            forCellReuseIdentifier: ButtonTableCell.identifier
        )
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
                    self.tableView.alpha = 1.0
                    self.tableView.transform = CGAffineTransform.identity
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
                    self.tableView.alpha = 0.0
                    self.tableView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }
            )
        }
    }
    
    private func updateFloaingButtonUI() {
        let image = UIImage.icnCrossINormalWhite16Px.withRenderingMode(.alwaysTemplate)
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
    
    // MARK: - Network
    
    private func connectAPI() {
        self.networkManager.homeAPI { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                yearReportCount = response.yearReportCount ?? 0
                monthReportCount = response.monthReportCount ?? 0
                mileage = response.mileage ?? 0
                bannerList = response.bannerList
                for banner in bannerList {
                    bannerListImgUrl.append(banner.bannerUrl ?? "")
                }
                collectionView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


// MARK: - Extension TableView

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ButtonTableCell.identifier,
            for: indexPath
        ) as? ButtonTableCell else {
            return UITableViewCell()
        }
        cell.configure(with: tableItems[indexPath.row])
        cell.frame.self.size.height = 40
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .clear
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


// MARK: - Extension CollectionView

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
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
            cell.configure(with: indexPath.item, yearReportCount: yearReportCount, monthReportCount: monthReportCount)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyReportBannerCell.cellIdentifier,
                for: indexPath
            ) as? MyReportBannerCell else {
                return UICollectionViewCell(frame: .zero)
            }
            cell.configure(bannerListImgUrl: bannerListImgUrl)
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
                rightHeaderItem: .mileageLabel), mileage: mileage)
        case 1:
            header.configure(with: MainHeaderItem(
                section: .banner,
                title: nil,
                rightHeaderItem: nil), mileage: nil)
        case 2:
            header.configure(with: MainHeaderItem(
                section: .finishedReport,
                title: "주요 처리 사례",
                rightHeaderItem: .moreButton), mileage: nil)
        default :
            break
        }
        return header
    }
}
