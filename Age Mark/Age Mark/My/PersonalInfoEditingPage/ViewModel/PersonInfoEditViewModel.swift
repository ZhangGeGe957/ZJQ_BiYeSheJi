//
//  PersonInfoEditViewModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/30.
//

import UIKit

class PersonInfoEditViewModel: NSObject {
    
    public var tableViewCellNumber: NSInteger = 0 // cell个数
    public var itemInfo: [EditItemInfo] = [] // 每个cell的信息
    
    override init() {
        
        itemInfo.append(EditItemInfo(imageName: "Edit_Name_Image", itemName: "用户名", itemDescribe: "请填写您想要修改的用户名"))
        itemInfo.append(EditItemInfo(imageName: "Edit_Sign_Image", itemName: "个性签名", itemDescribe: "请填写您想要修改的个性签名"))
        
        tableViewCellNumber = itemInfo.count
    }
}

class EditItemInfo {
    public var imageName = ""
    public var itemName = ""
    public var itemDescribe = ""
    
    init(imageName: String = "", itemName: String = "", itemDescribe: String = "") {
        self.imageName = imageName
        self.itemName = itemName
        self.itemDescribe = itemDescribe
    }
}
