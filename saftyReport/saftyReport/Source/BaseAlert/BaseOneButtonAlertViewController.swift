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
    
    /// confirmButton은 필요할 경우 overriding하여 액션 변경할 것.
    func setAddtarget() {
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
