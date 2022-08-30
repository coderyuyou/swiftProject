//
//  UIColor+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/17.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 将十六进制颜色转换为UIColor
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16)/255,
                  green: CGFloat((hex & 0x00FF00) >> 8)/255,
                  blue: CGFloat(hex & 0x0000FF)/255,
                  alpha: alpha)
    }
    
    /// 将十六进制颜色转换为UIColor
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var pHexString = hexString
        if hexString.hasPrefix("#") {
            pHexString.remove(at: pHexString.firstIndex(of: "#")!)
        }
        if  pHexString.count < 6 {
            self.init(white : 1, alpha : 1)
        } else {
            // 存储转换后的数值
            var r_v: UInt32 = 0, g_v: UInt32 = 0, b_v: UInt32 = 0
            // 分别转换进行转换
            Scanner(string: pHexString[0..<2]).scanHexInt32(&r_v)
            Scanner(string: pHexString[2..<4]).scanHexInt32(&g_v)
            Scanner(string: pHexString[4..<6]).scanHexInt32(&b_v)
            self.init(red: CGFloat(r_v) / 255.00,
                      green: CGFloat(g_v) / 255.0,
                      blue: CGFloat(b_v) / 255.0,
                      alpha: alpha)
        }
    }
    
    /// 将RGBA转换为UIColor
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: CGFloat(a) / 255.0)
    }
    
    /// 返回随机颜色
    class var randomColor: UIColor {
        UIColor(red: CGFloat(arc4random()%256)/255.00,
                green: CGFloat(arc4random()%256)/255.00,
                blue: CGFloat(arc4random()%256)/255.00,
                alpha: 1.00)
    }
}

