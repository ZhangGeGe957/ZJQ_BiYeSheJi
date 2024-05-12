//
//  UserInfoModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/29.
//

import Foundation
import UIKit

class UserInfoModel: NSObject {
    
    public var avatarImage: UIImage? = nil
    public var userName: String = ""
    public var userSign: String = ""
    
    override init() {
        avatarImage = nil
        userName = "Xiyouedc"
        userSign = "美好的明天"
    }
}
