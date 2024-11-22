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
    
    private var isChecked = false
    
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
        
        // border color가 기존 사용하던 UIColor가 아니라 CGColor여서 사전 세팅해 둔 색상을 사용 못 함 ㅜㅜ
        // 그래서 일단 대충 보기에 비슷하게 만들어두긴 했는데,,, 흠
        $0.layer.borderColor = CGColor(gray: 0.8, alpha: 0.3)
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
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
    
    @objc private func checkboxTapped() {
        isChecked.toggle()
        
        if isChecked {
            checkbox.setBackgroundImage(.icnCheckboxISquareSelectedWhite24Px, for: .normal)
        } else {
            checkbox.setBackgroundImage(.icnCheckboxISquareUnselectedWhite24Px, for: .normal)
        }
    }
    
}
