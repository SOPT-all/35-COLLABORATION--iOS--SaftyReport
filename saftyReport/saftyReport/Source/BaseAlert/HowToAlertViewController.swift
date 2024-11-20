//
//  AlertTestViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

import SnapKit
import Then

class HowToAlertViewController: UIViewController {
    
    let labelAlertButton = UIButton().then {
        $0.setTitle("Label Alert  띄우기", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
    }
    
    let imageAlertButton = UIButton().then {
        $0.setTitle("View Alert 띄우기", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        labelAlertButton.addTarget(self, action: #selector(presentLabelAlert), for: .touchUpInside)
        imageAlertButton.addTarget(self, action: #selector(presentImageAlert), for: .touchUpInside)
    }
    
    private func setUI() {
        view.backgroundColor = .green
        
        view.addSubviews(labelAlertButton, imageAlertButton)
        
        labelAlertButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageAlertButton.snp.makeConstraints {
            $0.top.equalTo(labelAlertButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func presentLabelAlert() {
        let tempView = UIView()
        let label = UILabel()
        
        label.attributedText = NSAttributedString.styled(
            text: "안녕하세요 라벨 추가한 예시입니다", style: .body4)
        
        tempView.addSubview(label)
        
        tempView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview()
        }
        
        AlertManager.presentOneButtonAlert(title: "알림", content: tempView, vc: self)
    }
    
    @objc func presentImageAlert() {
        let tempView = UIView()
        let image = UIImageView()
        
        image.image = UIImage(systemName: "photo")
        
        tempView.addSubview(image)
        
        tempView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        AlertManager.presentTwoButtonAlert(title: "알림", content: tempView, vc: self)
    }
}
