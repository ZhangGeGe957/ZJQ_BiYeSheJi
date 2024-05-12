//
//  RegisterTextFieldView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/5.
//

import Foundation
import UIKit

class RegisterTextFieldView: UIView {
    
    lazy private var accountTitleLabel = makeTextFieldTitleLabel()
    lazy private var accountTextField = makeTextField()
    lazy private var passwordTitleLabel = makeTextFieldTitleLabel()
    lazy private var passwordTextField = makeTextField()
    lazy private var confirmTitleLabel = makeTextFieldTitleLabel()
    lazy private var confirmTextField = makeTextField()
    lazy private var registerButton = makeRegisterButton()
    
    public var callbackClickRegisterButton: ((RegisterErrorCode) -> Void)?
    
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
        self.addSubview(confirmTitleLabel)
        self.addSubview(confirmTextField)
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
        
        confirmTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(50)
            make.height.equalTo(50)
        }
        
        confirmTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmTextField.snp_topMargin).offset(-10)
            make.right.equalTo(confirmTextField.snp_rightMargin)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(confirmTextField.snp_bottomMargin).offset(60)
            make.height.equalTo(60)
        }
    }
    
    private func setupInfo() {
        accountTitleLabel.text = "账号"
        accountTextField.placeholder = "请输入您的账号"
        
        passwordTitleLabel.text = "密码"
        passwordTextField.placeholder = "请输入您的密码"
        passwordTextField.isSecureTextEntry = true
        
        confirmTitleLabel.text = "确认密码"
        confirmTextField.placeholder = "请再次输入您的密码"
        confirmTextField.isSecureTextEntry = true
    }
    
}

// Public
extension RegisterTextFieldView {
    public func setDelegate(delegate: UITextFieldDelegate?) {
        accountTextField.delegate = delegate
        passwordTextField.delegate = delegate
        confirmTextField.delegate = delegate
    }
}

// 响应事件
extension RegisterTextFieldView {
    @objc
    private func clickRegisterButton() {
        
        var errorCode: RegisterErrorCode = .isValid
        
        // 判断手机号
        let phoneNumber = accountTextField.text ?? ""
        let isPhoneNumberValue = isPhoneNumber(phoneNumber: phoneNumber)
        if !isPhoneNumberValue {
            errorCode = .phoneNumberError
        }
        
        // 判断密码
        let firstString = passwordTextField.text ?? ""
        let secondString = confirmTextField.text ?? ""
        let isPasswordValue = judgmentPassword(firstString: firstString, secondString: secondString)
        if errorCode == .phoneNumberError && !isPasswordValue {
            errorCode = .allError
        } else if !isPasswordValue {
            errorCode = .passwordError
        }
        
        if errorCode == .isValid {
            if checkHaveThisPhoneNumber() {
                errorCode = .accountAlreadyExists
            } else {
                storeAccountInfo()
            }
        }
        
        if callbackClickRegisterButton != nil {
            callbackClickRegisterButton?(errorCode)
        }
    }
}

extension RegisterTextFieldView {
    // 判断手机号
    private func isPhoneNumber(phoneNumber: String) -> Bool {
        // 手机号码正则表达式
        let regex = "^1\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatch = predicate.evaluate(with: phoneNumber)

        return isMatch
    }
    
    // 判断密码
    private func judgmentPassword(firstString: String, secondString: String) -> Bool {
        
        // 判断密码长度
        if firstString.count < 8 {
            return false
        }
        
        // 判断两次输入的密码是否相同
        if !(firstString == secondString) {
            return false
        }
        return true
    }
    
    // 存储到数据库
    private func storeAccountInfo() {
        let accountText : String = accountTextField.text ?? ""
        let passwordText : String = passwordTextField.text ?? ""
        let insertSQL = "INSERT INTO 't_User' (userPhoneNumber, userPassword, userName, userSign, userSex) VALUES ('\(accountText)', '\(passwordText)', 'Default', 'Default', '男');"
        if SQLiteManager.shareInstance().execSQL(SQL: insertSQL) == true {
            print("[SQLiteManager]: 数据插入成功")
        }
    }
    
    // 判断数据库中是否有该账号
    private func checkHaveThisPhoneNumber() -> Bool {
        let querySQL = "SELECT userPhoneNumber, userPassword FROM 't_User';"
        // 取出查询到的结果
        let resultDataArr = SQLiteManager.shareInstance().queryDataBase(querySQL: querySQL)

        for dict in (resultDataArr)! {
            let userModel = UserAccountInfoModel(userPhoneNumber: dict["userPhoneNumber"] as! String, userPassword: dict["userPassword"] as! String)
            if userModel.userPhoneNumber == accountTextField.text {
                return true
            }
        }
        
        return false
    }
}

// 工厂方法
extension RegisterTextFieldView {
    
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
    
    private func makeRegisterButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitle("注  册", for: .normal)
        button.backgroundColor = UIColor(hex: "#93A6FE")
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(clickRegisterButton), for: .touchUpInside)
        return button
    }
}
