//
//  YYConstants.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/15.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit

// UI
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let ScreenBounds = UIScreen.main.bounds
let StatusBarSize = UIApplication.shared.statusBarFrame.size
let StatusBarWidth = max(StatusBarSize.width, StatusBarSize.height)
let StatusBarHeight = min(StatusBarSize.width, StatusBarSize.height)
let NavigationBarHeight: CGFloat = 44.0
let StatusNavigationBarHeight = StatusBarHeight + NavigationBarHeight
let TabbarHeight: CGFloat = DeviceIsFaceID ? 83.0 : 49.0

let PadViewContainerHeight: CGFloat = ScreenHeight - 90 * 1.6 - 62 * 1.6
let PadViewContainerWidth: CGFloat = PadViewContainerHeight * ScreenHeight / ScreenWidth

let UIDesignWidth: CGFloat = 375
let UIDesignHeight: CGFloat = 667

let ScreenHeightScale: CGFloat = ScreenHeight / 667
let ScreenScale: CGFloat = ScreenWidth / 375

let SafeAreaInsets: UIEdgeInsets = Dev.iPhoneX ? UIEdgeInsets.init(top: 24, left: 0, bottom: 17, right: 0) : UIEdgeInsets.zero
let SafeTopHeight: CGFloat = SafeAreaInsets.top
let SafeBottomHeight: CGFloat = SafeAreaInsets.bottom


// 颜色
let COLOR_CoverColor = UIColor.init(hex: 0x2b272c, alpha: 0.74)
let COLOR_CoverBtnNormal = UIColor.init(hex: 0x15f7ff)
let COLOR_CoverBtnHighlighted = UIColor.init(hex: 0x00d8ff)
let COLOR_CoverBtnDisabled = UIColor.init(hex: 0x4f8b9c)
let COLOR_NavBackground = UIColor.white
let COLOR_TabBarTitle = UIColor(hex: 0x232A4A)
let COLOR_TintColor = UIColor(hex: 0x32B2F7)
let COLOR_TitleColor = UIColor(hex: 0x0D73AD)
let COLOR_BackgroundColor = UIColor(hex: 0x999999)

// 字体
let FONT_TabBarTitle = UIFont.systemFont(ofSize: 11)
let FONT_NavBarTitle = UIFont.systemFont(ofSize: 26)


let currentDevice = Device()
let DeviceIsFaceID = currentDevice.isFaceIDCapable
let IsPad = currentDevice.isPad
let IsIPhoneXSeries = Dev.iPhoneX

// MARK: 设备
class Dev: NSObject {
    
    static let iPhone4 = {
        return ScreenHeight < 481
    }()
    
    static let iPhone5 = {
        return ScreenHeight < 600 && ScreenHeight > 500
    }()
    
    static let iPhonePlus = {
        return ScreenWidth > 375 && ScreenHeight > 667
    }()
    
    static let iPhoneX = {
        return ScreenHeight / ScreenWidth > 17 / 9.0
    }()
}
