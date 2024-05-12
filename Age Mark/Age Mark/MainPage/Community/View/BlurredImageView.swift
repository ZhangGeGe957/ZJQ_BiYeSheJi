//
//  BlurredImageView.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/2/1.
//

import UIKit

class BlurredImageView: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        // 创建渐变图层
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        // 设置渐变色
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        
        // 设置渐变方向
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        // 创建模糊效果视图
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        
        // 将渐变图层添加到模糊效果视图上
        blurEffectView.layer.mask = gradientLayer
        
        // 将模糊效果视图添加到图像视图上
        addSubview(blurEffectView)
    }
}
