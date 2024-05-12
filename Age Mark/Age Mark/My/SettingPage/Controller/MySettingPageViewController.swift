//
//  MySettingPageViewController.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/5/10.
//

import Foundation
import UIKit
import SnapKit

class MySettingPageViewController: UIViewController {
    
    lazy private var titleLabel: UILabel = makeTitleLabel()
    lazy private var signOutButton: UIButton = makeSignOutButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.view.addSubview(self.signOutButton)
        self.signOutButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(50)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
}

extension MySettingPageViewController {
    @objc
    private func clickSignOutButton() {
        let rootViewController = LogInViewController()
        let currentWindow = keyWindow()
        currentWindow.rootViewController = rootViewController
    }
    
    @objc
    private func showWarningAlert() {
        let alertController = UIAlertController(title: "提示", message: "您确定要登出吗？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            self?.clickSignOutButton()
        }
        let closeAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MySettingPageViewController {
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "设置"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }
    
    private func makeSignOutButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("登出", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#93A6FE")
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(showWarningAlert), for: .touchUpInside)
        return button
    }
}
