//
//  SceneDelegate.swift
//  saftyReport
//
//  Created by 이지훈 on 11/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 1.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 2.
        self.window = UIWindow(windowScene: windowScene)
        // 3.
        let tabBarViewcontroller = UITabBarController()
        
        let nav1 = UINavigationController(rootViewController: MainViewController())
        let nav2 = UINavigationController(rootViewController: ReportViewController())
        let nav3 = UINavigationController(rootViewController: ViewController())
        let nav4 = UINavigationController(rootViewController: ViewController())
        let nav5 = UINavigationController(rootViewController: ViewController())
        
        tabBarViewcontroller.setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
        tabBarViewcontroller.tabBar.tintColor = .primaryOrange
        
        nav1.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage.icnHomeLineGrey24Px,
            selectedImage: UIImage.icnHomeFilledOrange24Px
        )
        nav2.tabBarItem = UITabBarItem(
            title: "안전신고",
            image: UIImage.icnSafetyLineGrey24Px,
            selectedImage: UIImage.icnSafetyFilledOrange24Px
        )
        nav3.tabBarItem = UITabBarItem(
            title: "범죄예방",
            image: UIImage.icnDangerLineGrey24Px ,
            selectedImage: UIImage.icnDangerFilledOrange24Px
        )
        nav4.tabBarItem = UITabBarItem(
            title: "안전뉴스",
            image: UIImage.icnNewspaperLineGrey24Px,
            selectedImage: UIImage.icnNewspaperFilledOrange24Px
        )
        nav5.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage.icnPersonLineGrey24Px,
            selectedImage: UIImage.icnPersonFilledOrange24Px
        )
        
        self.window?.rootViewController = tabBarViewcontroller
        // 4.
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

