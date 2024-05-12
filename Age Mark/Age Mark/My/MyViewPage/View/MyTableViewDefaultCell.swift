//
//  MyTableViewDefaultCell.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/2.
//

import UIKit
import SnapKit

enum RightItemView {
    case arrowView
    case switchView
}

class MyTableViewDefaultCell: UITableViewCell {
    
    lazy public var iconImageView = makeIconImageView()
    lazy public var contentLabel = makeContentLabel()
    lazy private var arrowImageView = makeArrowImageView()
    lazy private var switchView = makeSwitchView()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 20
            frame.size.width -= 2 * 20
            super.frame = frame
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white

        contentView.addSubview(iconImageView)
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(switchView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.size.equalTo(30)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp_right).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.size.equalTo(18)
        }
        switchView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func addShadow() {
        
        // 父视图添加阴影
        let shadowSize = 1.0 //阴影大小
        let shadowRect = CGRect(x: -shadowSize, y: shadowSize * 2, width: contentView.bounds.size.width + shadowSize * 2, height: contentView.bounds.size.height - shadowSize * 4)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath.init(rect: shadowRect).cgPath
    }
    
    public func rightFuncItem(rightView: RightItemView) {
        switch rightView {
        case .arrowView:
            arrowImageView.isHidden = false
        case .switchView:
            switchView.isHidden = false
        }
    }
}

extension MyTableViewDefaultCell {
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    private func makeContentLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(hex: "#7B6F72")
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }
    
    private func makeArrowImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Arrow_Image")
        imageView.isHidden = true
        return imageView
    }
    
    private func makeSwitchView() -> UISwitch {
        let view = UISwitch()
        view.isHidden = true
        view.onTintColor = UIColor(hex: "#C58BF2")
        return view
    }
}

