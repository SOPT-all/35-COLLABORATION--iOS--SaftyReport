//
//  AlertAction.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class AlertManager {
    static func presentOneButtonAlert(title: String, contentView: UIView,
                                      mode: AlertMode,
                                      vc: UIViewController) {
        let alertVC = BaseOneButtonAlertViewController()
        alertVC.setAlert(title, contentView, mode)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        vc.present(alertVC, animated: true)
    }
    
    static func presentTwoButtonAlert(title: String,
                                      contentView: UIView,
                                      vc: UIViewController) {
        let alertVC = BaseTwoButtonAlertViewController()
        alertVC.setAlert(title, contentView)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        vc.present(alertVC, animated: true)
    }
}
