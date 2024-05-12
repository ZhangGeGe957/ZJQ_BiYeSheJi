//
//  EnterARButton.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/15.
//

import Foundation
import ARKit

class EnterARButton: UIView {
    lazy private var backgroundImageView: UIImageView = makeImageView()
    lazy private var ARImageView: UIImageView = makeImageView()
    lazy private var ARLabel: UILabel = makeARNameLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundImageView.image = UIImage(named: "ARModel_Button_BackgroundImageView")
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ARImageView.image = UIImage(named: "ARMode_Button_ImageView")
        addSubview(ARImageView)
        ARImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(6)
            make.width.equalTo(23.33)
            make.height.equalTo(25.46)
        }
        
        ARLabel.text = "AR"
        addSubview(ARLabel)
        ARLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(8)
            make.width.equalTo(23)
            make.height.equalTo(22)
        }
    }
}

extension EnterARButton {
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func makeARNameLabel() -> UILabel {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
}
