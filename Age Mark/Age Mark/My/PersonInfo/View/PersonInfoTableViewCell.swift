//
//  PersonInfoTableViewCell.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/4/23.
//

import Foundation
import UIKit
import SnapKit

class PersonInfoTableViewCell: UITableViewCell {
    
    lazy private var nameLabel = makeNameLabel()
    lazy private var contentLabel = makeContentLabel()
    public var nameString: String = "" {
        didSet {
            nameLabel.text = self.nameString
        }
    }
    public var contentString: String = "" {
        didSet {
            contentLabel.text = self.contentString
        }
    }
    lazy private var lineLabel = makeLineLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if reuseIdentifier == "cell" {
            setupUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(lineLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-30)
        }
        lineLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - 工厂方法
extension PersonInfoTableViewCell {
    private func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }
    
    private func makeContentLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }
    
    private func makeLineLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        return label
    }
}
