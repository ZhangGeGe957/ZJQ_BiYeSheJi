//
//  LogInViewController.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/3/27.
//

import Foundation
import UIKit
import SnapKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    lazy private var appIconView = makeAppIconView()
    lazy private var logInTextFieldView = makeLogInTextFieldView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(appIconView)
        self.view.addSubview(logInTextFieldView)
        
        appIconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(DefaultData.shared().screenWidth)
            make.height.equalTo(DefaultData.shared().screenWidth)
        }
        
        logInTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(appIconView.snp_bottomMargin).offset(10)
            make.leading.rightMargin.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    // 获取当前window
    private func keyWindow() -> UIWindow {
         if #available(iOS 15.0, *) {
             let keyWindow = UIApplication.shared.connectedScenes
                 .map({ $0 as? UIWindowScene })
                 .compactMap({ $0 })
                 .first?.windows.first ?? UIWindow()
             return keyWindow
         }else {
             let keyWindow = UIApplication.shared.windows.first ?? UIWindow()
             return keyWindow
         }
     }

    // 展示主页
    private func showMainViewController() {
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
        let currentWindow = keyWindow()
        currentWindow.rootViewController = tabBar
        
        // 解决滑动滚动视图，tabBar背景色变化
        if #available(iOS 15.0, *) {
            let appearnce = UITabBarAppearance()
            appearnce.configureWithOpaqueBackground()
            appearnce.backgroundColor = .white
            tabBar.tabBar.standardAppearance = appearnce
            tabBar.tabBar.scrollEdgeAppearance = appearnce
         }
    }
    
    // 展示注册页
    private func showRegisterViewController() {
        let registerViewController = makeRegisterViewController()
        self.present(registerViewController, animated: true)
    }
}

// MARK: TextFieldDelegate
extension LogInViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }
}

// MARK: 工厂方法
extension LogInViewController {
    private func makeAppIconView() -> AppIconView {
        let view = AppIconView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.titleText = "登录"
        return view
    }
    
    private func makeLogInTextFieldView() -> LogInTextFieldView {
        let view = LogInTextFieldView()
        view.setDelegate(delegate: self)
        view.callbackClickLogInButton = { [weak self] (errorCode) in
            var tipsMessage: String = ""
            switch errorCode {
            case .logInSuccess:
                tipsMessage = "登录成功"
            case .accountNotExist:
                tipsMessage = "该账号不存在"
            case .passwordError:
                tipsMessage = "请输入正确的密码"
            }
            
            let alertController = UIAlertController(title: "提示", message: tipsMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .cancel) { [weak self] (alertAction) in
                if errorCode == .logInSuccess {
                    self?.showMainViewController()
                }
            }
            alertController.addAction(action)
            self?.present(alertController, animated: true)
        }
        view.callbackClickRegisterButton = { [weak self] in
            self?.showRegisterViewController()
        }
        return view
    }
    
    private func makeRegisterViewController() -> RegisterViewController {
        let viewController = RegisterViewController()
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
}
