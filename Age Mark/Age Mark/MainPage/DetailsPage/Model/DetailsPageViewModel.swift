//
//  DetailsPageViewModel.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/19.
//

import UIKit

class DetailsPageViewModel: NSObject {
    
    public var tableViewSection: Int = 0
    
    // 初始化Model
    override init() {
        tableViewSection = 2
    }
}

class MonumentsInfo {
    var name: String = ""
    var describe: String = ""
    var photoArray: Array<String> = []
}
