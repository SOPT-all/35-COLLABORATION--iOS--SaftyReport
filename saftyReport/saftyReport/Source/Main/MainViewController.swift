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
    let customNavigationItem = CustomNavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setNavigationBar()
    }
    
//    private func setUI() {
//
//        
//    }
//    
//    private func setLayout() {
//        
//        
//    }
//    
    private func setNavigationBar() {
        title = ""
        
        navigationController?.setNavigationBar()
        customNavigationItem.setupNavigationBar(for: .leftRight)

        navigationItem.leftBarButtonItem = customNavigationItem.leftBarButtonItem
        navigationItem.rightBarButtonItem = customNavigationItem.rightBarButtonItem
    }
}
