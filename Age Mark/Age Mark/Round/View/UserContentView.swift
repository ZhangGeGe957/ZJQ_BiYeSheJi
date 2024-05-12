//
//  UserContentView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/18.
//

import Foundation
import UIKit
import SnapKit

class UserContentView: UIView {
    
    lazy public var userAvatarImage: UIImageView = makeUserAvaterImageView()
    lazy public var userNameLabel: UILabel = makeUserNameLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(userAvatarImage)
        userAvatarImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(40)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(userAvatarImage.snp_right).offset(10)
            make.width.equalTo(100)
        }
    }
}

extension UserContentView {
    private func makeUserAvaterImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    private func makeUserNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }
}
