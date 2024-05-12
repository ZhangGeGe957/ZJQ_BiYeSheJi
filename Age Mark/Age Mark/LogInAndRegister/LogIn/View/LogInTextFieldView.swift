//
//  LogInTextFieldView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/1.
//

import Foundation
import UIKit
import SnapKit

class LogInTextFieldView: UIView {
    
    lazy private var accountTitleLabel = makeTextFieldTitleLabel()
    lazy private var accountTextField = makeTextField()
    lazy private var passwordTitleLabel = makeTextFieldTitleLabel()
    lazy private var passwordTextField = makeTextField()
    lazy private var logInButton = makeLogInButton()
    lazy private var registerButton = makeRegisterButton()
    
    public var callbackClickLogInButton: ((LogInErrorCode) -> Void)?
    public var callbackClickRegisterButton: (() -> Void)?
    
    private var accountInfo: UserAccountInfoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupUI()
        
        setupInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(accountTitleLabel)
        self.addSubview(accountTextField)
        self.addSubview(passwordTitleLabel)
        self.addSubview(passwordTextField)
        self.addSubview(logInButton)
        self.addSubview(registerButton)
        
        accountTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(50)
        }
        
        accountTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(accountTextField.snp_topMargin).offset(-10)
            make.right.equalTo(accountTextField.snp_rightMargin)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(accountTextField.snp_bottomMargin).offset(50)
            make.height.equalTo(50)
        }
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp_topMargin).offset(-10)
            make.right.equalTo(passwordTextField.snp_rightMargin)
        }
        
        logInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(60)
            make.height.equalTo(60)
        }
        
        registerButton.snp.makeConstraints { make in
            make.right.equalTo(logInButton.snp_rightMargin)
            make.top.equalTo(logInButton.snp_bottomMargin).offset(10)
        }
    }
    
    private func setupInfo() {
        accountTitleLabel.text = "账号"
        accountTextField.placeholder = "请输入您的账号"
        
        passwordTitleLabel.text = "密码"
        passwordTextField.placeholder = "请输入您的密码"
        passwordTextField.isSecureTextEntry = true
    }
    
}

// Public
extension LogInTextFieldView {
    public func setDelegate(delegate: UITextFieldDelegate?) {
        accountTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
}

extension LogInTextFieldView {
    // 判断账号
    private func checkHaveThisPhoneNumber() -> Bool {
        
        // 重制账号信息
        accountInfo = nil
        
        let querySQL = "SELECT userPhoneNumber, userPassword FROM 't_User';"
        // 取出查询到的结果
        let resultDataArr = SQLiteManager.shareInstance().queryDataBase(querySQL: querySQL)

        for dict in (resultDataArr)! {
            let userModel = UserAccountInfoModel(userPhoneNumber: dict["userPhoneNumber"] as! String, userPassword: dict["userPassword"] as! String)
            if userModel.userPhoneNumber == accountTextField.text {
                accountInfo = userModel
                return true
            }
        }
        
        return false
    }
}

// 响应事件
extension LogInTextFieldView {
    @objc 
    private func clickLogInButton() {
        var errorCode: LogInErrorCode = .logInSuccess
        
        if !checkHaveThisPhoneNumber() {
            errorCode = .accountNotExist
        } else {
            if accountInfo?.userPassword != passwordTextField.text {
                errorCode = .passwordError
            }
        }
        
        if callbackClickLogInButton != nil {
            callbackClickLogInButton?(errorCode)
        }
    }
    
    @objc
    private func clickRegisterButton() {
        if callbackClickRegisterButton != nil {
            callbackClickRegisterButton?()
        }
    }
}

// 工厂方法
extension LogInTextFieldView {
    
    private func makeTextFieldTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        return label
    }
    
    private func makeTextField() -> UITextField {
        let field = UITextField()
        field.layer.cornerRadius = 15
        field.layer.masksToBounds = true
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.gray.cgColor
        return field
    }
    
    private func makeLogInButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitle("登  录", for: .normal)
        button.backgroundColor = UIColor(hex: "#93A6FE")
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(clickLogInButton), for: .touchUpInside)
        return button
    }
    
    private func makeRegisterButton() -> UIButton {
        let button = UIButton()
        button.setTitle("注册账号", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(clickRegisterButton), for: .touchUpInside)
        return button
    }
}
