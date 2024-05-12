//
//  CommunityPhotoCell.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/7.
//

import UIKit
import SnapKit

class CommunityPhotoCell : UICollectionViewCell {
    
    lazy public var photoImageView: BlurredImageView = makePhotoImageView()
    lazy public var titleLabel: UILabel = makeTitleLabel()
    public var itemName: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 圆角和边缘线
        layer.masksToBounds = true;
        layer.cornerRadius = 15.0;
        layer.borderWidth = 0.2;
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleLabel)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview()
        })
    }
}

extension CommunityPhotoCell {
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        return label
    }
    
    private func makePhotoImageView() -> BlurredImageView {
        let imageView = BlurredImageView(frame: CGRectZero)
        return imageView
    }
}
