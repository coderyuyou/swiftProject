//
//  YYBaseViewController.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/15.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

class YYBaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    var navBarColor: UIColor = COLOR_BackgroundColor {
        didSet {
            self.setNavBarColor()
        }
    }
    var navTintColor: UIColor = COLOR_TintColor {
        didSet {
            self.setNavTintColor()
        }
    }
    
    var navTitleColor: UIColor = COLOR_TitleColor {
        didSet {
            self.setNavTitleColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = COLOR_BackgroundColor   //消除残影
        self.navigationController?.navigationBar.isTranslucent = false
         
         self.view.backgroundColor = COLOR_BackgroundColor
         self.navTintColor = COLOR_TintColor
         self.navBarColor = COLOR_NavBackground
         self.navTitleColor = COLOR_TitleColor
         self.createBackBtn()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavBarColor()
        self.setNavTintColor()
        self.setNavTitleColor()
    }
    
    private func createBackBtn() {
        guard let nav = self.navigationController else { return }
        if nav.viewControllers.count > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(popBack))
        }
    }
    
    private func setNavBarColor() {
        guard let nav = self.navigationController else { return }
        let case1 = !nav.navigationBar.isHidden && self == self.navigationController?.topViewController
        let case2 = self.tabBarController?.selectedViewController == self.navigationController
        guard case1 || case2 else {
            return
        }
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(with: navBarColor, size: CGSize(width: YYLayout.ScreenWidth, height: 1))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(with: navBarColor, size: CGSize(width: YYLayout.ScreenWidth, height: 1)), for: .default)
        var white: CGFloat = 0
        let get = self.navBarColor.getWhite(&white, alpha: nil)
        UIApplication.shared.statusBarStyle = get && (white > 0.9) ? .default : .lightContent
    }
    
    private func setNavTintColor() {
        guard let nav = self.navigationController else { return }
        let case1 = !nav.navigationBar.isHidden && self == self.navigationController?.topViewController
        let case2 = self.tabBarController?.selectedViewController == self.navigationController
        guard case1 || case2 else {
            return
        }
        self.navigationController?.navigationBar.tintColor = self.navTintColor
        self.navigationController?.navigationBar.isTranslucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: self.navTintColor], for: .normal)
        return
        
    }
    
    private func setNavTitleColor() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: self.navTitleColor]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
    //        return .bottom
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc func popBack() {
        guard let nav = self.navigationController else { return }
        if let index = nav.viewControllers.index(of: self), index > 0 {
            if let vc = nav.viewControllers[index - 1] as? YYBaseViewController {
                self.navTintColor = vc.navTintColor
                self.navBarColor = vc.navBarColor
                self.navTitleColor = vc.navTitleColor
            }
        }
        nav.popViewController(animated: true)
    }
    
    func popLongBack(to getClass: AnyClass) {
        guard let nav = self.navigationController else { return }
        var popVC : YYBaseViewController?
        nav.viewControllers.forEach { (vc) in
            if vc.isKind(of: getClass) {
                popVC = vc as? YYBaseViewController
            }
        }
        guard let backVC = popVC else { return }
        self.navTintColor = backVC.navTintColor
        self.navBarColor = backVC.navBarColor
        self.navTitleColor = backVC.navTitleColor
        nav.popToViewController(backVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("\(type(of: self)) 销毁")
    }
}
