//
//  UserAccountInfoModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/8.
//

import UIKit

enum LogInErrorCode: NSInteger {
    case logInSuccess = 0
    case accountNotExist = 1
    case passwordError = 2
}

class UserAccountInfoModel: NSObject {
    var userPhoneNumber : String = ""
    var userPassword : String = ""
    
    init(userPhoneNumber : String, userPassword : String) {
            self.userPhoneNumber = userPhoneNumber
            self.userPassword = userPassword
    }
    
    override init() {
        super.init()
    }
}
