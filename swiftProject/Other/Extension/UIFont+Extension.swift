//
//  UIFont+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/20.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension UIFont {

    /// 设置适配iPhone屏幕的一般字体
    class func set_systemFont(iphoneFont: CGFloat) -> UIFont {
        
        return set_systemFont(iphoneFont, 0)
    }
    /// 设置适配iPhone屏幕的加粗字体
    class func set_boldFont(iphoneFont: CGFloat) -> UIFont {
        
        return set_boldFont(iphoneFont, 0)
    }
    /// 设置适配iPad屏幕的一般字体
    class func set_systemFont(ipadFont: CGFloat) -> UIFont {
        
        return set_systemFont(0, ipadFont)
    }
    /// 设置适配iPad屏幕的加粗字体
    class func set_boldFont(ipadFont: CGFloat) -> UIFont {
        
        return set_boldFont(0, ipadFont)
    }
    
    class func set_systemFont(_ iphoneFont: CGFloat, _ ipadFont: CGFloat) -> UIFont {
        
        let width = UIScreen.main.bounds.size.width
        if IsPad {
            return UIFont.init(name: "PingFangSC-Regular", size: width / 768 * ipadFont)!
        }
        return UIFont.init(name: "PingFangSC-Regular", size: width / 375 * iphoneFont)!
    }
    
    class func set_boldFont(_ iphoneFont: CGFloat, _ ipadFont: CGFloat) -> UIFont {
        
        let width = UIScreen.main.bounds.size.width
        if IsPad {
            return UIFont.boldSystemFont(ofSize: width / 768 * ipadFont)
        }
        return UIFont.boldSystemFont(ofSize: width / 375 * iphoneFont)
    }
}


