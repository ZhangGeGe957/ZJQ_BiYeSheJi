//
//  CommunitySearchCell.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/6.
//

import UIKit
import SnapKit

class CommunitySearchCell : UICollectionViewCell {
    
    // 获取屏幕的宽和高
    private let Width = UIScreen.main.bounds.width
    private let Height = UIScreen.main.bounds.height
    
    private var frontImageView: UIImageView!
    public var textField: UITextField!
    lazy public var closeButton: UIButton = makeCloseButton()
    private var dividerLabel: UILabel!
    private var backImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 15.0;
        self.layer.borderWidth = 0.2;
        
        self.frontImageView = UIImageView(image: UIImage(named: "Icon-Search"))
        self.contentView.addSubview(self.frontImageView)
        self.frontImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(30)
        }
        
        self.backImageView = UIImageView(image: UIImage(named: "Icon-Search-More"))
        self.contentView.addSubview(self.backImageView)
        self.backImageView.snp.makeConstraints { make in
            make.top.equalTo(self.frontImageView.snp_top)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(30)
        }
        
        self.dividerLabel = UILabel()
        self.dividerLabel.layer.borderWidth = 0.2
        self.contentView.addSubview(self.dividerLabel)
        self.dividerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.backImageView.snp_top)
            make.right.equalTo(self.backImageView.snp_left).offset(-8)
            make.width.equalTo(0.2)
            make.height.equalTo(self.backImageView.snp_height)
        }
        
        textField = UITextField()
        textField.textAlignment = .left
        textField.minimumFontSize = 15
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString.init(string:"请输入您想去的地方", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(self.frontImageView.snp_right).offset(10)
            make.right.equalTo(self.backImageView.snp_left).offset(-10)
            make.top.equalTo(self.frontImageView.snp_top)
            make.bottom.equalTo(self.frontImageView.snp_bottom)
        }
        
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(dividerLabel.snp_left).offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(23)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommunitySearchCell {
    private func makeCloseButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Icon_Close_Search"), for: .normal)
        button.isHidden = true
        return button
    }
}

