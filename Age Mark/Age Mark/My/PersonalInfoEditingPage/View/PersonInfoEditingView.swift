//
//  PersonInfoEditingView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/31.
//

import UIKit
import SnapKit

class PersonInfoEditingView: UIView {
    
    lazy public var iconImageView = makeImageView()
    lazy public var nameLabel = makeNameLabel()
    lazy public var inputTextField = makeTextField()
    lazy private var bottomLine = makeBottomLine()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(inputTextField)
        addSubview(bottomLine)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp_right)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(-0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonInfoEditingView {
    private func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    private func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.textColor = .black
        return textField
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    private func makeBottomLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}
