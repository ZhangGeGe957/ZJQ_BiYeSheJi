//
//  BaseTableViewCell.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/28.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell {
    
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // 重写单元格初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
}
