//
//  AlertTestViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

import SnapKit
import Then

final class HowToAlertViewController: UIViewController {
    // MARK: - 📢 안내사항
    /*
     본 VC는 Alert을 어떻게 사용하는지 알려드리기 위해 예시로 만든 것입니다.
     '⭐️'이 붙은 부분은 여러분들이 자신의 뷰컨에 입력해야 하는 코드입니다.
     Alert의 ContentView만 잘 설정하고, 제가 작성한 예시의 플로우를 잘 따라가신다면 문제 없을 겁니다.
     궁금한 점이 있다면 언제든 편하게 연락주십쇼! */
    
    
    // MARK: - Properties
    
    let labelAlertButton = UIButton().then {
        $0.setTitle("Label Alert  띄우기", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
    }
    
    let imageAlertButton = UIButton().then {
        $0.setTitle("View Alert 띄우기", for: .normal)
        $0.setTitleColor(.tintColor, for: .normal)
    }
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        // ⭐️ 4. addTarget하여 버튼에 액션 설정
        labelAlertButton.addTarget(self, action: #selector(presentLabelAlert), for: .touchUpInside)
        imageAlertButton.addTarget(self, action: #selector(presentImageAlert), for: .touchUpInside)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubviews(labelAlertButton, imageAlertButton)
        
        labelAlertButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageAlertButton.snp.makeConstraints {
            $0.top.equalTo(labelAlertButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: - Objc functions
    
    @objc func presentLabelAlert() {
        // ⭐️ 1. Alert의 ContentView에 삽입할 프로퍼티 선언
        let contentView = UIView()
        let label = UILabel()
        
        // ⭐️ 2. ContentView에 들어가는 프로퍼티 디자인
        label.attributedText = NSAttributedString.styled(
            text: "안녕하세요 라벨 추가한 예시입니다", style: .body4)
        
        contentView.addSubview(label)
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview()
        }
        
        // ⭐️ 3. AlertManager를 활용해 oneButton 또는 twoButton Alert을 소환
        AlertManager.presentTwoButtonAlert(title: "알림", contentView: contentView, vc: self)
    }
    
    @objc func presentImageAlert() {
        let contentView = UIView()
        let image = UIImageView()
        
        image.image = UIImage(systemName: "photo")
        
        contentView.addSubview(image)
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        AlertManager.presentOneButtonAlert(title: "소방차 전용구역 불법주차",
                                           contentView: contentView,
                                           mode: .info,
                                           vc: self)
    }
}
