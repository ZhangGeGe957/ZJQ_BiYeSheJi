//
//  DetailsPageContentView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/19.
//

import UIKit

class DetailsPageContentView: UIView {
    
    // UI
    public var contentLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置UI
    private func setupUI() {
        
        contentLabel = UILabel()
        contentLabel?.textColor = .black
        contentLabel?.font = UIFont.systemFont(ofSize: 17)
        contentLabel?.numberOfLines = 0
        addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        })
    }
}
