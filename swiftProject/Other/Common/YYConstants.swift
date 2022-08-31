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
struct YYLayout {
    
    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    static let ScreenBounds = UIScreen.main.bounds
    static let StatusBarSize = UIApplication.shared.statusBarFrame.size
    static let StatusBarWidth = max(StatusBarSize.width, StatusBarSize.height)
    static let StatusBarHeight = min(StatusBarSize.width, StatusBarSize.height)
    static let NavigationBarHeight: CGFloat = 44.0
    static let StatusNavigationBarHeight = StatusBarHeight + NavigationBarHeight
    static let TabbarHeight: CGFloat = YYDevice.isFullScreen ? 83.0 : 49.0

    static let PadViewContainerHeight: CGFloat = ScreenHeight - 90 * 1.6 - 62 * 1.6
    static let PadViewContainerWidth: CGFloat = PadViewContainerHeight * ScreenHeight / ScreenWidth

    static let UIDesignWidth: CGFloat = 375
    static let UIDesignHeight: CGFloat = 667

    static let ScreenHeightScale: CGFloat = ScreenHeight / 667
    static let ScreenScale: CGFloat = ScreenWidth / 375

    static let SafeAreaInsets: UIEdgeInsets = YYDevice.isFullScreen ? UIEdgeInsets.init(top: 24, left: 0, bottom: 17, right: 0) : UIEdgeInsets.zero
    static let SafeTopHeight: CGFloat = SafeAreaInsets.top
    static let SafeBottomHeight: CGFloat = SafeAreaInsets.bottom
}

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

/// 设备
struct YYDevice {
    static let current = Device.current
    static let isPad = Device.current.isPad
    static let isPhone = Device.current.isPhone
    static var isFullScreen: Bool {
        let allXSeriesDevices = Device.allDevicesWithSensorHousing
        let state = allXSeriesDevices.contains(Device.current)
        return state
    }
}

/// sandbox
struct YYDirectory {
    ///
    static var documentPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first ?? ""
    }
    static var tempPath: String {
        return NSTemporaryDirectory()
    }
}
