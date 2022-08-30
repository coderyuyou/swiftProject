//
//  Dictionary+Extension.swift
//  swiftProject
//
//  Created by yuyou on 2022/8/30.
//  Copyright © 2022 SuperYu. All rights reserved.
//

import UIKit

extension Dictionary  {
    
    func toJSONString() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: self,options: .prettyPrinted) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func gx_toJSONData() throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: self)
        return data
    }
}
