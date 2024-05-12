//
//  DetailsPageShowImageView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/17.
//

import UIKit
import SnapKit
import ARKit
import SceneKit

class DetailsPageShowImageView: UIView, UIScrollViewDelegate {
    
    lazy var imageScrollView: UIScrollView = makeImageScrollView(pageNum: 1)
    public var photoArray: Array<String>? {
        didSet {
            imageScrollView = makeImageScrollView(pageNum: photoArray!.count)
            
            updateImageScrollView()
        }
    }
    
    private var imageWidth: CGFloat = DefaultData.shared().screenWidth
    private var imageHeight: CGFloat = DefaultData.shared().screenHeight / 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateImageScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateImageScrollView() {
        addSubview(imageScrollView)
        imageScrollView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for (index, value) in (photoArray ?? []).enumerated() {
            let imageView = UIImageView(image: UIImage(named: value))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.backgroundColor = .white
            imageScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.left.equalTo(imageScrollView.snp_left).offset(CGFloat(index) * imageWidth)
                make.width.equalTo(imageWidth)
                make.height.equalTo(imageHeight)
            }
        }
    }
}


// MARK: - 工厂方法
extension DetailsPageShowImageView {
    private func makeImageScrollView(pageNum: Int) -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        scrollView.contentSize = CGSize(width: imageWidth * CGFloat(pageNum), height: imageHeight)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        return scrollView
    }
}
