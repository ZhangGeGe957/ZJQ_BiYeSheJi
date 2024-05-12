//
//  RegisterViewController.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/4.
//

import Foundation
import UIKit
import SnapKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    lazy private var appIconView = makeAppIconView()
    lazy private var backButton = makeBackButton()
    lazy private var registerTextFieldView = makeRegisterTextFieldView()
    
    private var registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(appIconView)
        self.view.addSubview(backButton)
        self.view.addSubview(registerTextFieldView)
        
        appIconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(DefaultData.shared().screenWidth)
            make.height.equalTo(DefaultData.shared().screenWidth)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(32)
        }
        
        registerTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(appIconView.snp_bottomMargin).offset(10)
            make.leading.rightMargin.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: TextFieldDelegate
extension RegisterViewController {
}

// 响应事件
extension RegisterViewController {
    @objc
    private func clickBackButton() {
        self.dismiss(animated: true)
    }
}

// MARK: 工厂方法
extension RegisterViewController {
    private func makeAppIconView() -> AppIconView {
        let view = AppIconView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.titleText = "注册"
        return view
    }
    
    private func makeBackButton() -> UIButton {
        let button = UIButton(type: .close)
        button.setImage(UIImage(named: "back_button_image"), for: .normal)
        button.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        return button
    }
    
    private func makeRegisterTextFieldView() -> RegisterTextFieldView {
        let view = RegisterTextFieldView()
        view.setDelegate(delegate: self)
        view.callbackClickRegisterButton = { [weak self] (errorCode) in
            var tipsMessage: String = ""
            switch errorCode {
            case .isValid:
                tipsMessage = "注册成功"
            case .phoneNumberError:
                tipsMessage = "请输入正确的手机号"
            case .passwordError:
                tipsMessage = "请输入正确的密码"
            case .allError:
                tipsMessage = "请输入正确的信息"
            case .accountAlreadyExists:
                tipsMessage = "该账号已存在"
            }
            
            let alertController = UIAlertController(title: "提示", message: tipsMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .cancel) { [weak self] (alertAction) in
                if errorCode == .isValid {
                    self?.dismiss(animated: true)
                }
            }
            alertController.addAction(action)
            self?.present(alertController, animated: true)
        }
        return view
    }
}
