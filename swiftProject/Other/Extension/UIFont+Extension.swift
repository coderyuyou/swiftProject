//
//  UIFont+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/20.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension UIFont {
    
    /// 自适应字体 - system
    /// - Parameter size: 标准屏大小
    /// - Returns: 自适应大小
    class func fitSystemFont(_ size: CGFloat) -> UIFont {
        let tmpSize = getScreenScale(size)
        return UIFont.systemFont(ofSize: tmpSize)
    }
    
    /// 自适应字体 - bold
    /// - Parameter size: 标准屏大小
    /// - Returns: 自适应大小
    class func fitBoldFont(_ size: CGFloat) -> UIFont {
        let tmpSize = getScreenScale(size)
        return UIFont.boldSystemFont(ofSize: tmpSize)
    }
    
    /// 自适应字体
    /// - Parameters:
    ///   - name: 字体名
    ///   - size: 标准屏大小
    /// - Returns: 自适应大小
    class func fitSystem(name: String, size: CGFloat) -> UIFont {
        let tmpSize = getScreenScale(size)
        return UIFont(name: name, size: tmpSize) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 区别iPad iPhone 字体自适应大小
    private class func getScreenScale(_ size: CGFloat) -> CGFloat {
        var tmpSize = size
        if YYDevice.isPhone {
            tmpSize = YYLayout.ScreenWidth / 375 * size
        } else if YYDevice.isPad {
            tmpSize = YYLayout.ScreenWidth / 768 * size
        }
        return tmpSize
    }
}


