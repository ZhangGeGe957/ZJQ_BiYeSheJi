//
//  RegisterViewModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/7.
//

import Foundation
import UIKit

enum RegisterErrorCode: NSInteger {
    case isValid = 0
    case phoneNumberError = 1
    case passwordError = 2
    case allError = 3
    case accountAlreadyExists = 4
}

class RegisterViewModel: NSObject {
    
    override init() {
    }
}
