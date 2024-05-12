//
//  SceneDelegate.swift
//  Age Mark
//
//  Created by 王璐 on 2023/6/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        let rootViewController = LogInViewController()
//        self.window?.rootViewController = rootViewController
        
        let tabBar: UITabBarController = UITabBarController()
        let communityView: CommunityViewController = CommunityViewController()
        communityView.tabBarItem.selectedImage = UIImage(named: "Community_Page_Image_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        communityView.tabBarItem.imageInsets = UIEdgeInsets(top: 50, left: 30, bottom: 10, right: 20)
        communityView.tabBarItem.image = UIImage(named: "Community_Page_Image_No_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let roundView: RoundViewController = RoundViewController()
        roundView.tabBarItem.selectedImage = UIImage(named: "Round_Page_Image_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        roundView.tabBarItem.image = UIImage(named: "Round_Page_Image_No_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        roundView.tabBarItem.imageInsets = UIEdgeInsets(top: 50, left: 20, bottom: 10, right: 30)
        
        let myView: MyViewController = MyViewController()
        myView.tabBarItem.selectedImage = UIImage(named: "My_Page_Image_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myView.tabBarItem.image = UIImage(named: "My_Page_Image_No_Select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myView.tabBarItem.imageInsets = UIEdgeInsets(top: 65, left: 20, bottom: 15, right: 25)
        
        // 整合到tabBar中
        tabBar.viewControllers = [communityView, roundView, myView]
        tabBar.tabBar.backgroundColor = UIColor.white
        self.window?.rootViewController = tabBar
        
        // 解决滑动滚动视图，tabBar背景色变化
        if #available(iOS 15.0, *) {
            let appearnce = UITabBarAppearance()
            appearnce.configureWithOpaqueBackground()
            appearnce.backgroundColor = .white
            tabBar.tabBar.standardAppearance = appearnce
            tabBar.tabBar.scrollEdgeAppearance = appearnce
         }
        
        guard let _ = (scene as? UIWindowScene) else { return }
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

