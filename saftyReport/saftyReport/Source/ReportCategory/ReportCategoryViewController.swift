//
//  ReportCategoryViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/26/24.
//

import UIKit

class ReportCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let reportCategoryView = ReportCategoryView()
    private var dataSource: UITableViewDiffableDataSource<ReportCategory.Section, ReportCategory.Item>! = nil
    
    
    // MARK: - Methods
    
    override func loadView() {
        view = reportCategoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDataSource()
        applyInitialSnapshots()
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
//        reportCategoryView.tableView.dataSource = UITableViewDiffableDataSource
        dataSource = UITableViewDiffableDataSource
            <ReportCategory.Section, ReportCategory.Item>(tableView:
                                                            reportCategoryView.tableView) {
                [weak self] (tableView: UITableView,
                             indexPath: IndexPath,
                             item: ReportCategory.Item) -> UITableViewCell? in
                guard let self = self else { return nil }
                
                switch item.toggleState {
                case .normal:
                    guard let cell = reportCategoryView.tableView.dequeueReusableCell(
                        withIdentifier: ReportCategoryNormalTableViewCell.identifier,
                        for: indexPath
                    ) as? ReportCategoryNormalTableViewCell else { return nil }
                    
                    cell.bind(item: item)
                    return cell
                    
                case .expanded:
                    guard let cell = reportCategoryView.tableView.dequeueReusableCell(withIdentifier: ReportCategoryExpandedTableViewCell.identifier, for: indexPath) as? ReportCategoryExpandedTableViewCell else { return nil }
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

extension ReportCategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("sections: \(ReportCategory.Section.allCases.count)개")
        return ReportCategory.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rows: \(dataSource.snapshot().itemIdentifiers(inSection: ReportCategory.Section.allCases[section]).count)개")
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
        
        switch item.toggleState {
        case .normal:
            return 58 + 10
        case .expanded:
            return 258 + 10
        }
    }
}
