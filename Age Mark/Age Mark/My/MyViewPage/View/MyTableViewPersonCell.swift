//
//  MyTableViewPersonCell.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/4.
//

import UIKit
import SnapKit

class MyTableViewPersonCell: UITableViewCell {
    
    lazy public var avatarImageView: UIImageView = makeAvatarImageView()
    lazy public var personNameLabel: UILabel = makePersonNameLabel()
    lazy public var personSignLabel: UILabel = makePersonSignLabel()
    lazy public var editButton: UIButton = makeEditButton()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 20
            frame.origin.y += 10
            frame.size.width -= 2 * 20
            frame.size.height -= 10
            super.frame = frame
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .white
        
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.size.equalTo(80)
        }
        
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.width.equalTo(83)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(personNameLabel)
        personNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.avatarImageView.snp_top).offset(10)
            make.left.equalTo(self.avatarImageView.snp_right).offset(20)
            make.right.equalTo(self.editButton.snp_left).offset(-20)
        }
        
        contentView.addSubview(personSignLabel)
        personSignLabel.snp.makeConstraints { make in
            make.top.equalTo(personNameLabel.snp_bottom).offset(5)
            make.left.equalTo(personNameLabel.snp_left)
            make.right.equalTo(self.editButton.snp_left).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addUpperRoundedCornersAndShadow()
    }
    
    private func addUpperRoundedCornersAndShadow() {
        
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSizeMake(1, 1)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 5
    }
    
}

extension MyTableViewPersonCell {
    private func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }
    
    private func makeEditButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("编辑", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "edit_Button_Background"), for: .normal)
        return button
    }
    
    private func makePersonNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }
    
    private func makePersonSignLabel() -> UILabel {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }
    
}

