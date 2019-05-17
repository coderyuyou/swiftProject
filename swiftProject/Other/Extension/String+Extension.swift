//
//  String+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/17.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension String {
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    func replacingLocalizedStringPlaceholder(with string: String) -> String {
        return self.replacingOccurrences(of: "***", with: string)
    }
    
    ///定位子字符串(NSRange)
    func nsRange(of string: String) -> NSRange {
        guard let range = self.range(of: string) else { return NSRange(location: 0, length: 0) }
        return NSRange(range, in: self)
    }
    
    func positionOf(sub: String, backwards: Bool = false) -> Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of: sub, options: backwards ? .backwards : .literal) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    func appendingPath(path: String) -> String {
        if let lastChar = self.last {
            let pathFirstChar = path.first
            return (lastChar == "/" || pathFirstChar == "/") ? self.appending(path) : self.appending("/\(path)")
        }
        return path
    }
    
    func estimatedSize(withFont font: UIFont, maxWidth: CGFloat) -> CGSize {
        let string = self as NSString
        return string.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
}
