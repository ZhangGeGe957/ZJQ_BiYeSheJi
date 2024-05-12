//
//  ARTopChangeModelView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/25.
//

import Foundation
import UIKit
import SnapKit

class ARTopChangeModelView: UIView {
    
    // 返回按钮
    lazy public var backButton: UIButton = makeBackButton()
    // tab按钮
    lazy private var tabButton: UIButton = makeTabButton()
    // 分享按钮
    lazy private var shareButton: UIButton = makeShareButton()
    // 数据
    private let screenWidth: CGFloat = DefaultData.shared().screenWidth
    private let screenHeight: CGFloat = DefaultData.shared().screenHeight
    
    // Block
    public var backButtonCallBack: (() -> Void)?
    public var tabButtonCallBack: ((Bool) -> Void)?
    public var shareButtonCallBack: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(45)
        }
        
        self.addSubview(tabButton)
        tabButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset((screenWidth - 160) / 2)
            make.top.equalTo(backButton).offset(0)
            make.width.equalTo(163)
            make.height.equalTo(45)
        }
        
        self.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(backButton)
            make.width.equalTo(60)
            make.height.equalTo(45)
        }
    }
    
}

// MARK: - 点击事件
extension ARTopChangeModelView {
    @objc
    private func clickTabButton() {
        tabButton.isSelected = !tabButton.isSelected
        if tabButtonCallBack != nil {
            tabButtonCallBack?(tabButton.isSelected)
        }
    }
    
    @objc
    private func clickBackButton() {
        if backButtonCallBack != nil {
            backButtonCallBack?()
        }
    }
    
    @objc
    private func clickShareButton() {
        if shareButtonCallBack != nil {
            shareButtonCallBack?()
        }
    }
}

// MARK: - 工厂方法
extension ARTopChangeModelView {
    private func makeTabButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "ARModel_Tab_Object"), for: .normal)
        button.setImage(UIImage(named: "ARModel_Tab_AR"), for: .selected)
        button.addTarget(self, action: #selector(clickTabButton), for: .touchUpInside)
        button.isSelected = false
        return button
    }
    
    private func makeBackButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "ARModel_BackButton"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        return button
    }
    
    private func makeShareButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "ARModel_Share"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(clickShareButton), for: .touchUpInside)
        return button
    }
}
