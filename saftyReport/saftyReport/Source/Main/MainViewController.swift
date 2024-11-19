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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setUpNavigationBar()
    }

    private func setUpNavigationBar() {
        navigationController?.setUpNavigationBarColor()
        customNavigationItem.setUpNavigationBar(for: .leftRight)
        customNavigationItem.setUpTitle(title: "")

        navigationItem.title = customNavigationItem.title
        navigationItem.leftBarButtonItem = customNavigationItem.leftBarButtonItem
        navigationItem.rightBarButtonItem = customNavigationItem.rightBarButtonItem
    }
}
