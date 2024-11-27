//
//  ReportViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then

// 추후 삭제할 파일임
class ReportViewController: UIViewController {
    
    lazy var pushButton = UIButton().then {
        $0.setTitleColor(.primaryOrange, for: .normal)
        $0.setTitle("신고 카테고리 선택 뷰 보기", for: .normal)
        $0.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray1
        
        view.addSubview(pushButton)
        
        pushButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func pushVC() {
        let vc = ReportCategoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
