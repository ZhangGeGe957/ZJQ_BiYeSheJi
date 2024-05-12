//
//  MyTableViewSectionFooter.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/2/1.
//

import UIKit
 
class MyTableViewSectionFooter: UIView {
    
    
    lazy private var backgroundView = makeBackgroundView()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 20
            frame.size.width -= 2 * 20
            frame.size.height -= 20
            super.frame = frame
        }
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        backgroundColor = UIColor.clear
         
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        addSubview(backgroundView)
        
        addUpperRoundedCornersAndShadow(subView: backgroundView, parentView: self, radius: 15, corners: [.bottomLeft, .bottomRight])
    }
    
    private func addUpperRoundedCornersAndShadow(subView: UIView, parentView: UIView, radius: CGFloat, corners: UIRectCorner) {
        // 添加子视图圆角
        let maskPath = UIBezierPath(roundedRect: subView.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        subView.layer.mask = maskLayer
        
        // 父视图添加阴影
        let shadowSize = 1.0
        let shadowRect = CGRect(x: -shadowSize, y: shadowSize * 8, width: parentView.bounds.size.width + shadowSize * 2, height: parentView.bounds.size.height - shadowSize * 6)
        parentView.layer.shadowColor = UIColor.black.cgColor
        parentView.layer.shadowOpacity = 0.1
        parentView.layer.masksToBounds = false
        parentView.layer.shadowPath = UIBezierPath.init(roundedRect: shadowRect, cornerRadius: radius).cgPath
    }
}

extension MyTableViewSectionFooter {
    
    private func makeBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}
