//
//  RoundButtonView.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/13.
//

import UIKit
import SnapKit

class RoundButtonView: UIView {
    
    // 获取屏幕的宽和高
    private let Width = UIScreen.main.bounds.width
    private let Height = UIScreen.main.bounds.height
    
    public var recommendButton: UIButton!
    public var focusOnButton: UIButton!
    public var nearbyButton: UIButton!
    public var addContentButton: UIButton!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        // 状态栏高度
        let statusBarHeight = UIApplication.shared.statusBarFrame.height;
        // 顶部的安全距离
        let topSafeAreaHeight = (statusBarHeight - 20)
        
        frame = CGRect(x: 0, y: topSafeAreaHeight, width: Width, height: 80)
        
        // 设置初始状态下的按钮标题样式
        let normalTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 25),
            .foregroundColor: UIColor.black
        ]
        // 设置选中状态下的按钮标题样式
        let selectedTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 26),
            .foregroundColor: UIColor.black
        ]
        
        recommendButton = UIButton(type: .custom)
        recommendButton.setTitleColor(.black, for: .normal)
        recommendButton.setAttributedTitle(NSAttributedString(string: "推荐", attributes: normalTitleAttributes), for: .normal)
        recommendButton.setAttributedTitle(NSAttributedString(string: "推荐", attributes: selectedTitleAttributes), for: .selected)
        recommendButton.isSelected = true
        addSubview(recommendButton)
        recommendButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        focusOnButton = UIButton(type: .custom)
        focusOnButton.setTitleColor(.black, for: .normal)
        focusOnButton.setAttributedTitle(NSAttributedString(string: "关注", attributes: normalTitleAttributes), for: .normal)
        focusOnButton.setAttributedTitle(NSAttributedString(string: "关注", attributes: selectedTitleAttributes), for: .selected)
        addSubview(focusOnButton)
        focusOnButton.snp.makeConstraints { make in
            make.left.equalTo(recommendButton.snp_right).offset(20)
            make.bottom.equalTo(recommendButton.snp_bottom)
        }
        
        nearbyButton = UIButton(type: .custom)
        nearbyButton.setTitleColor(.black, for: .normal)
        nearbyButton.setAttributedTitle(NSAttributedString(string: "附近", attributes: normalTitleAttributes), for: .normal)
        nearbyButton.setAttributedTitle(NSAttributedString(string: "附近", attributes: selectedTitleAttributes), for: .selected)
        addSubview(nearbyButton)
        nearbyButton.snp.makeConstraints { make in
            make.left.equalTo(focusOnButton.snp_right).offset(20)
            make.bottom.equalTo(recommendButton.snp_bottom)
        }
        
        addContentButton = UIButton(type: .custom)
        addContentButton.setImage(UIImage(named: "Round_AddContent_Button"), for: .normal)
        addSubview(addContentButton)
        addContentButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp_right).offset(-20)
            make.size.equalTo(40)
        }
    }
}
