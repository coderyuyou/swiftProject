//
//  UIcolor+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/17.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16)/255, green: CGFloat((hex & 0x00FF00) >> 8)/255, blue: CGFloat(hex & 0x0000FF)/255, alpha: alpha)
    }
    
    /// 将十六进制颜色转换为UIColor
    convenience init(hexString: String, alpha:CGFloat = 1.0) {
        var pureHexString = hexString
        if hexString.hasPrefix("#") {
            pureHexString.remove(at: pureHexString.firstIndex(of: "#")!)
        }
        
        // 存储转换后的数值
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: pureHexString[0..<2]).scanHexInt32(&red)
        
        Scanner(string: pureHexString[2..<4]).scanHexInt32(&green)
        
        Scanner(string: pureHexString[4..<6]).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        // 存储转换后的数值
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
    }
    
}

