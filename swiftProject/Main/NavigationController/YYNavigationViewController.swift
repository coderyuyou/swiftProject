//
//  YYNavigationViewController.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/15.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

class YYNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = self
    }

}

//MARK:- 侧滑返回上一页
extension YYNavigationViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }
}
