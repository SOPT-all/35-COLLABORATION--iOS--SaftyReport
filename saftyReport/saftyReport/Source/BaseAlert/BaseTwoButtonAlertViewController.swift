//
//  BaseTwoButtonAlertViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class BaseTwoButtonAlertViewController: UIViewController {
    let alertView = BaseTwoButtonAlertView()
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setAlert(_ title: String, _ content: UIView) {
        alertView.setAlert(title, content)
    }
    
    // TODO: dismiss 액션: exitButton, backgroundButton
    // TODO: confirm 액션: confirmButton
    
}
