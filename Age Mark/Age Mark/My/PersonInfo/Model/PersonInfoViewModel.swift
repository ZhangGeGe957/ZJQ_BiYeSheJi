//
//  PersonInfoViewModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/23.
//

import Foundation

class PersonInfoViewModel: NSObject {
    
    public var nameArray: Array<String> = []
    public var contentArray: Array<String> = []
    
    override init() {
        super.init()
        
        nameArray = ["昵称", "个性签名", "手机号", "性别"]
        
        contentArray = ["Uphold.957", "1111", "18592073883", "男"]
    }
}
