//
//  CommunityWelcomeCell.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/5.
//

import UIKit
import SnapKit

class CommunityWelcomeCell : UICollectionViewCell {
    
    private var welcomeLabel: UILabel!
    private var placeLabel: UILabel!
    public var notionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to"
        welcomeLabel.textAlignment = .left
        welcomeLabel.textColor = UIColor.black
        welcomeLabel.font = UIFont.systemFont(ofSize: 30)
        contentView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(10)
        }
        
        placeLabel = UILabel()
        placeLabel.text = "Explore the world"
        placeLabel.textAlignment = .left
        placeLabel.textColor = UIColor.black
        placeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        contentView.addSubview(placeLabel)
        placeLabel.snp.makeConstraints { make in
            make.left.equalTo(welcomeLabel.snp_left)
            make.top.equalTo(welcomeLabel.snp_bottom).offset(10)
        }
        
        notionButton = UIButton(type: .custom)
        notionButton.setBackgroundImage(UIImage(named: "Notification-Icon"), for: .normal)
        contentView.addSubview(notionButton)
        notionButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.size.equalTo(25)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
