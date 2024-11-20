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
        
        
    }
    
    func setAlert(_ title: String, _ content: UIView, _ mode: AlertMode) {
        alertView.setAlert(title, content, mode)
    }
    
    // TODO: dismiss 액션: exitButton, backgroundButton
    // TODO: confirm 액션: confirmButton
    
}
