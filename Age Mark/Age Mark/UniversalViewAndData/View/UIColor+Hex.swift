//
//  UIColor+Hex.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2024/1/18.
//

import Foundation
import UIKit

extension UIColor {
      public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
          let start = hex.index(hex.startIndex, offsetBy: 1)
          let hexColor = String(hex[start...])

          if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
              r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
              g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
              b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
              a = CGFloat(hexNumber & 0x000000ff) / 255

              self.init(red: r, green: g, blue: b, alpha: a)
              return
            }
          } else if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
              r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
              g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
              b = CGFloat((hexNumber & 0x0000ff)) / 255
              a = 1.0
              self.init(red: r, green: g, blue: b, alpha: a)
              return
            }
          }
        }

        return nil
      }
//    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
//        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(hex & 0x0000FF) / 255.0
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
}
