//
//  DefaultData.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/17.
//

import Foundation
import UIKit


class DefaultData {
    // 单例
    static let sharedManager: DefaultData = {
        let shared = DefaultData()
        return shared
    }()
    
    // 共享数据
    let statusBarHeight = UIApplication.shared.statusBarFrame.height // 状态栏高度
    let screenWidth = UIScreen.main.bounds.width // 屏幕宽度
    let screenHeight = UIScreen.main.bounds.height // 屏幕高度
    let topSafeAreaHeight = UIApplication.shared.statusBarFrame.height - 20
    
    private init() {}
    
    class func shared() -> DefaultData {
        return sharedManager
    }
}
