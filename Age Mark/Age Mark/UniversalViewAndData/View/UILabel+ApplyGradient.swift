//
//  UILabel+ApplyGradient.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/3/27.
//

import Foundation
import UIKit

extension UILabel {
    func applyGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = [0.0, 1.0]
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        textColor = UIColor(patternImage: image!)
    }
}
