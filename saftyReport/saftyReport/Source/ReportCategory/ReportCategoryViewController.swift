//
//  ReportCategoryViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/26/24.
//

import UIKit

class ReportCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dataSource: UITableViewDiffableDataSource<ReportCategory.Section,
                                                            ReportCategory.Item>! = nil
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
        setDataSource()
        applyInitialSnapshots()
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
    
    private func setDataSource() {
        dataSource = UITableViewDiffableDataSource
            <ReportCategory.Section, ReportCategory.Item>(tableView:
                                                            reportCategoryView.tableView) {
                [weak self] (tableView: UITableView,
                             indexPath: IndexPath,
                             item: ReportCategory.Item) -> UITableViewCell? in
                guard let self = self else { return nil }
                
                if item.isExpanded {
                    guard let cell = reportCategoryView.tableView.dequeueReusableCell(
                        withIdentifier: ReportCategoryExpandedTableViewCell.identifier,
                        for: indexPath
                    ) as? ReportCategoryExpandedTableViewCell else { return nil }
                    
                    cell.bind(item: item, at: self, reportButtonAction: #selector(pushReportDetailVC))
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
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<ReportCategory.Section, ReportCategory.Item>()
        snapshot.appendSections([.safety, .parking, .traffic, .environment])
        
        snapshot.appendItems(ReportCategory.Dummy.safety, toSection: .safety)
        snapshot.appendItems(ReportCategory.Dummy.parking, toSection: .parking)
        snapshot.appendItems(ReportCategory.Dummy.traffic, toSection: .traffic)
        snapshot.appendItems(ReportCategory.Dummy.environment, toSection: .environment)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


// MARK: - Objc functions

extension ReportCategoryViewController {
    @objc private func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func pushReportDetailVC() {
        let nextVC = ReportDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


// MARK: - TableView Extensions

extension ReportCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("sections: \(ReportCategory.Section.allCases.count)개")
        return ReportCategory.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.snapshot().itemIdentifiers(inSection: ReportCategory.Section.allCases[section]).count
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
