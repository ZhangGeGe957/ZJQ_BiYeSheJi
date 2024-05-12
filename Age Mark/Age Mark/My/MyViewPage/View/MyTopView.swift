//
//  MyTopView.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/1.
//

import UIKit
import SnapKit

class MyTopView : UIView {
    
    // 获取屏幕的宽和高
    private let Width = DefaultData.shared().screenWidth
    private let Height = DefaultData.shared().screenHeight
    
    lazy private var topTitleLabel = makeTopTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(topTitleLabel)
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
}

extension MyTopView {
    private func makeTopTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "个人信息"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        return label
    }
}
