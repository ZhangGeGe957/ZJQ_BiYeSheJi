//
//  SearchResultCell.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/3/5.
//

import UIKit
import SnapKit

class SearchResultCell: UITableViewCell {
    
    lazy private var titleLabel = makeTitleLabel()
    public var titleString = "" {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    lazy private var lineLabel = makeLineLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSubviewsLayout()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineLabel)
    }
    
    private func setupSubviewsLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        lineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.height.equalTo(0.5)
        }
    }
}

extension SearchResultCell {
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
    
    private func makeLineLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        return label
    }
}
