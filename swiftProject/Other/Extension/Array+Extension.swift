//
//  Array+Extension.swift
//  swiftProject
//
//  Created by yuyou on 2022/8/30.
//  Copyright © 2022 SuperYu. All rights reserved.
//

import Foundation

extension Array where Element: NSCopying {
    func copy() -> [Any] {
        var copyArray: [Any] = []
        forEach { e in
            copyArray.append(e.copy())
        }
        return copyArray
    }
}

extension Array where Element: Equatable {
    mutating func remove(object:Element) {
        if let idx = firstIndex(of: object) {
            remove(at: idx)
        }
    }
}

extension Array {
    
    func gx_toJSONString() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        if let dataValue = try? JSONSerialization.data(withJSONObject: self,options: .prettyPrinted) {
            return String(data: dataValue, encoding: .utf8)
        }
        return nil
    }
    
    /// 防止数组越界闪退
    ///
    /// - Parameters:
    ///   - index: 下标
    ///   - safe: 是否使用安全方式
    subscript(index idx: Int, useSafe safe: Bool = true) -> Element? {
        if safe {
            return (self.count > idx) ? self[idx] : nil
        } else {
            return self[idx]
        }
    }
}
