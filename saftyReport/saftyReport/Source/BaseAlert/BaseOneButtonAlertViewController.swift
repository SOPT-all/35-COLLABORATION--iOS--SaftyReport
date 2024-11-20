//
//  BaseAlertViewController.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class BaseOneButtonAlertViewController: UIViewController {
    let alertView = BaseTwoButtonAlertView()
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.setAlertTheme("알림")
    }

}
