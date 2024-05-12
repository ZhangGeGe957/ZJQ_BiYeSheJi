//
//  RoundTableViewCell.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/16.
//

import Foundation
import UIKit
import SnapKit

class RoundTableViewCell: UITableViewCell {
    
    lazy public var contentImageView: UIImageView = makeContentImageView()
    lazy public var userContentView: UserContentView = makeUserContentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(userContentView)
        
        contentImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalTo(userContentView.snp_top)
        }
        userContentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentImageView.snp_bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
}

extension RoundTableViewCell {
    private func makeContentImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }
    
    private func makeUserContentView() -> UserContentView {
        let view = UserContentView()
        return view
    }
}
