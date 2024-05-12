//
//  MyTableViewModel.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/2.
//

import UIKit

class MyTableViewModel: NSObject {
    
    public var sectionNameArray : NSArray!
    
    private var accountArray : NSArray!
    private var accountPhotoArray : NSArray!
    
    private var notificationArray : NSArray!
    private var notificationPhotoArray : NSArray!
    
    private var otherArray : NSArray!
    private var otherPhotoArray : NSArray!
    
    // 初始化Model
    override init() {
        self.sectionNameArray = NSArray(objects: "", "账号", "通知", "其他")
        
        self.accountArray = NSArray(objects: "个人信息", "我的成就", "活动记录", "旅行计划")
        self.accountPhotoArray = NSArray(objects: "Icon-Profile", "Icon-Achievement", "Icon-Activity", "Icon-Workout")
        
        self.notificationArray = NSArray(objects: "消息提醒")
        self.notificationPhotoArray = NSArray(objects: "Icon-Notif")
        
        self.otherArray = NSArray(objects: "联系我们", "个人隐私", "设置")
        self.otherPhotoArray = NSArray(objects: "Icon-Message", "Icon-Privacy", "Icon-Setting")
    }
    
    // 根据Section返回Model数据
    public func modelArrayWithSection(section: Int) -> NSArray {
        if (section == 1) {
            return self.accountArray
        } else if (section == 2) {
            return self.notificationArray
        } else if (section == 3) {
            return self.otherArray
        } else {
            return NSArray()
        }
    }
    
    // 根据Section返回PhotoModel数据
    public func photoModelArrayWithSection(section: Int) -> NSArray {
        if (section == 1) {
            return self.accountPhotoArray
        } else if (section == 2) {
            return self.notificationPhotoArray
        } else if (section == 3) {
            return self.otherPhotoArray
        } else {
            return NSArray()
        }
    }
}
