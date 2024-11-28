//
//  ReportCategoryViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/26/24.
//

import UIKit

import Alamofire

class ReportCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dataSource: UITableViewDiffableDataSource<CustomCategory.Section,
                                                            CustomCategory.Item>! = nil
    
    private let reportCategoryView = ReportCategoryView()
    
    private lazy var navigationBackButton = UIButton().then {
        $0.setImage(.icnArrowLeftLineWhite24Px, for: .normal)
        $0.addTarget(self, action: #selector(popSelf), for: .touchUpInside)
    }
    
    
    // MARK: - Methods
    
    override func loadView() {
        view = reportCategoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setTableView()
        fetchCategoryList()
        setDataSource()
    }
    
    private func setUpNavigationBar() {
        let customNavigationItem = CustomNavigationItem(title: "전체 보기")
        customNavigationItem.setUpNavigationBar(for: .backRight)
        
        let backBarButtonItem = UIBarButtonItem(customView: navigationBackButton)
        
        navigationController?.setUpNavigationBarColor()
        navigationItem.title = customNavigationItem.title
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = customNavigationItem.rightBarButtonItem
    }
    
    private func setTableView() {
        reportCategoryView.tableView.dataSource = self
        reportCategoryView.tableView.delegate = self
        
        reportCategoryView.tableView.register(
            ReportCategoryNormalTableViewCell.self,
            forCellReuseIdentifier: ReportCategoryNormalTableViewCell.identifier
        )
        
        reportCategoryView.tableView.register(
            ReportCategoryExpandedTableViewCell.self,
            forCellReuseIdentifier: ReportCategoryExpandedTableViewCell.identifier
        )
    }
    
    private func fetchCategoryList() {
        let endPoint = "/api/v1/report/category"
        let fullURL = Environment.baseURL + endPoint
        
        AF.request(
            fullURL,
            method: .get
        )
        .validate()
        .responseDecodable(of: CategoryResponse.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
                
            case .success(let response):
                let categoryDetailList = response.data.categoryDetailList
                var customCategoryItems: [CustomCategory.Item] = []
                
                categoryDetailList.forEach {
                    let description = String.bullet + " " + $0.categoryDescription
                        .replaceEscapeSequences()
                        .removeQuotes()
                    customCategoryItems.append(
                        CustomCategory.Item(
                            section: CustomCategory.configureSection(categoryID: $0.categoryId),
                            name: $0.categoryName,
                            description: description,
                            isExpanded: false))
                }
                
                applyInitialSnapshots(data: customCategoryItems)
                
            case .failure(let error):
                let label = UILabel().then {
                    $0.numberOfLines = 0
                    $0.text = "카테고리를 불러오는 데 실패했습니다. \n 인터넷 상태를 확인해주세요."
                    $0.textColor = .gray13
                }
                AlertManager.presentOneButtonAlert(
                    title: "네트워크 오류",
                    contentView: label,
                    mode: .alarm,
                    vc: self
                )
                print("Decoding Error: \(error)")
            }
        }
    }
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource
            <CustomCategory.Section, CustomCategory.Item>(tableView:
                                                            reportCategoryView.tableView) {
                [weak self] (tableView: UITableView,
                             indexPath: IndexPath,
                             item: CustomCategory.Item) -> UITableViewCell? in
                guard let self = self else { return nil }
                
                if item.isExpanded {
                    guard let cell = reportCategoryView.tableView.dequeueReusableCell(
                        withIdentifier: ReportCategoryExpandedTableViewCell.identifier,
                        for: indexPath
                    ) as? ReportCategoryExpandedTableViewCell else { return nil }
                    
                    cell.bind(item: item)
                    return cell
                    
                } else {
                    guard let cell = reportCategoryView.tableView.dequeueReusableCell(
                        withIdentifier: ReportCategoryNormalTableViewCell.identifier,
                        for: indexPath
                    ) as? ReportCategoryNormalTableViewCell else { return nil }
                    
                    cell.bind(item: item)
                    return cell
                }
            }
    }
    
    
    private func applyInitialSnapshots(data: [CustomCategory.Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<CustomCategory.Section, CustomCategory.Item>()
        snapshot.appendSections([.safety, .parking, .traffic, .environment])
        
        data.forEach {
            snapshot.appendItems([$0], toSection: $0.section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    // MARK: - Objc functions
    
    @objc private func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReportCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("sections: \(CustomCategory.Section.allCases.count)개")
        return CustomCategory.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.snapshot().itemIdentifiers(inSection: CustomCategory.Section.allCases[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("This method shouldn't be called as the data source. It is provided by the diffable data source.")
    }
}

extension ReportCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else { return UITableView.automaticDimension }
        
        if item.isExpanded {
            return 258 + 10
        } else {
            return 58 + 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        item.isExpanded.toggle()
        
        var snapshot = dataSource.snapshot()
        
        snapshot.insertItems([item], beforeItem: snapshot.itemIdentifiers(inSection: item.section)[indexPath.row])
        snapshot.deleteItems([dataSource.itemIdentifier(for: indexPath)!])
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
