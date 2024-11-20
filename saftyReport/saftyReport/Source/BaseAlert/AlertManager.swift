//
//  AlertAction.swift
//  saftyReport
//
//  Created by 김유림 on 11/20/24.
//

import UIKit

class AlertManager {
    static func presentOneButtonAlert(title: String?, content: UIView, vc: UIViewController) {
        let alertVC = BaseOneButtonAlertViewController()
        alertVC.setAlert("알림", content, .alarm)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        vc.present(alertVC, animated: true)
    }
    
    static func presentTwoButtonAlert(title: String?, content: UIView, vc: UIViewController) {
        let alertVC = BaseTwoButtonAlertViewController()
        alertVC.setAlert("알림", content)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        vc.present(alertVC, animated: true)
    }
}
