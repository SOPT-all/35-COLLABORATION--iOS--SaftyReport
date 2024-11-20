//
//  BaseAlertViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class BaseOneButtonAlertViewController: UIViewController {
    let alertView = BaseOneButtonAlertView()
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddtarget()
    }
    
    func setAddtarget() { // 필요할 경우 오버라이딩 가능하도록 internal로 선언
        alertView.backgroundButton.addTarget(self,
                                             action: #selector(dismissAlert),
                                             for: .touchUpInside)
        
        alertView.exitButton.addTarget(self,
                                       action: #selector(dismissAlert),
                                       for: .touchUpInside)
        
        alertView.confirmButton.addTarget(self,
                                          action: #selector(dismissAlert),
                                          for: .touchUpInside)
    }
    
    func setAlert(_ title: String, _ contentView: UIView, _ mode: AlertMode) {
        alertView.setAlert(title, contentView, mode)
    }
    
    @objc func dismissAlert() {
        self.dismiss(animated: true)
    }
}
