//
//  GalleryDetailViewController.swift
//  saftyReport
//
//  Created by OneTen on 11/22/24.
//

import UIKit

import SnapKit
import Then

class GalleryDetailViewController: UIViewController {
    var checkboxHandler: ((Bool, IndexPath) -> ())?
    var indexPath: IndexPath!

    var isChecked = false

    private var baseView = UIView().then {
        $0.backgroundColor = .gray1
    }
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
//        $0.image = .test
        $0.backgroundColor = .gray // 이미지 넣으면 지울 코드
    }
    
    private lazy var checkbox = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setBackgroundImage(.icnCheckboxISquareUnselectedWhite24Px, for: .normal)
        $0.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
        
    private var timeStackView = UIStackView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CGColor(gray: 0.8, alpha: 0.3)
        $0.spacing = 20
    }
    
    private var createdAtLabel = UILabel().then {
        $0.attributedText = .styled(text: "촬영일시", style: .caption1)
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .gray13
    }
    
    private var dateTimeLabel = UILabel().then {
        $0.attributedText = .styled(text: "2024/11/13   17:59:59", style: .caption1)
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .gray13
    }
    
    private var logoLabel = UILabel().then {
        $0.attributedText = .styled(text: "안전신문고", style: .caption1)
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .gray13
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray3.cgColor
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        checkbox.setBackgroundImage(
            isChecked ? .icnCheckboxISquareSelectedWhite24Px : .icnCheckboxISquareUnselectedWhite24Px,
            for: .normal
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        checkboxHandler?(isChecked, indexPath)
    }
    
    private func setUI() {
        self.view.addSubview(baseView)
        baseView.addSubviews(checkbox, imageView, timeStackView, logoLabel)
        timeStackView.addArrangedSubviews(createdAtLabel, dateTimeLabel)
    }
    
    private func setLayout() {
        baseView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        checkbox.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(36)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(469) // 이미지 넣으면 없앨 코드
            $0.center.equalToSuperview()
        }
        
        timeStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.width.equalTo(208)
            $0.height.equalTo(22)
        }
        
        createdAtLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
        }
        
        dateTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(createdAtLabel.snp.trailing).offset(20)
        }
        
        logoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.width.equalTo(68)
            $0.height.equalTo(22)
        }
        
    }
    
    private func setupNavigationBar() {
        let customNavigationItem = CustomNavigationItem()
        customNavigationItem.setUpNavigationBar(for: .back)
        navigationItem.backBarButtonItem = customNavigationItem.backBarButtonItem
        navigationItem.backBarButtonItem?.tintColor = .gray1
        navigationItem.title = "상세 보기"
    }
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
        
        if isChecked {
            checkbox.setBackgroundImage(.icnCheckboxISquareSelectedWhite24Px, for: .normal)
        } else {
            checkbox.setBackgroundImage(.icnCheckboxISquareUnselectedWhite24Px, for: .normal)
        }
    }
    
}
