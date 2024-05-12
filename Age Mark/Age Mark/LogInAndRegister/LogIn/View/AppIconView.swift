//
//  AppIconView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/3/27.
//

import Foundation
import UIKit
import SnapKit

class AppIconView: UIView {
    
    lazy private var appIconImageView = makeAppIconImageView()
    lazy private var titleLabel = makeTitleLabel()
    public var titleText: String = "" {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray3
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(appIconImageView)
        self.addSubview(titleLabel)
        
        appIconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(30)
            make.bottom.equalTo(self).offset(-15)
        }
    }
}

extension AppIconView {
    private func makeAppIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.alpha = 0.8
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.textColor = UIColor(hex: "#93A6FE")
        return label
    }
}
