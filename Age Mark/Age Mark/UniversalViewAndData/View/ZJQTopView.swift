//
//  ZJQTopView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/17.
//

import UIKit
import SnapKit

class ZJQTopView: UIView {
    
    lazy public var backButton: UIButton = makeBackButton()
    lazy public var titleLabel: UILabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化UI
    private func setupUI() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(44)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.width.equalTo(DefaultData.shared().screenWidth * 0.65)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
    }
}

extension ZJQTopView {
    private func makeBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ZJQTopView_BackButton"), for: .normal)
        return button
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }
}
