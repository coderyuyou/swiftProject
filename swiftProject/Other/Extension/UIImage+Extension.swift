//
//  UIImage+Extension.swift
//  swiftProject
//
//  Created by YuYou on 2019/5/15.
//  Copyright © 2019 SuperYu. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 中心点拉伸
    class func drawingPicturesCenter(name: String) -> UIImage {
        let img = UIImage(named: name)
        let leftCapWidth = img!.size.width / 2
        let topCapHeight = img!.size.height / 2
        
        return drawingPictures(img: img!, leftCap: Int(leftCapWidth), topCap: Int(topCapHeight))
    }
    
    /// x方向拉伸
    class func drawingPictureHorizontally(name: String) -> UIImage {
        let img = UIImage(named: name)
        let leftCapWidth = img!.size.width / 2
        
        return drawingPictures(img: img!, leftCap: Int(leftCapWidth), topCap: 0)
    }
    
    /// y方向拉伸
    class func drawingPictureVerticall(name: String) -> UIImage {
        let img = UIImage(named: name)
        let topCapHeight = img!.size.height / 2
        
        return drawingPictures(img: img!, leftCap: 0, topCap: Int(topCapHeight))
    }
    
    class func drawingPictures(img: UIImage, leftCap: Int, topCap: Int) -> UIImage {
        
        var resImg = UIImage()
        resImg = img.stretchableImage(withLeftCapWidth: leftCap, topCapHeight: topCap)
        return resImg
    }
    
    func tintedImage(with tintColor: UIColor) -> UIImage? {
        return self.tintedImage(with: tintColor, blendMode: .destinationIn)
    }
    func gradientImage(with tintColor: UIColor) -> UIImage? {
        return self.tintedImage(with: tintColor, blendMode: .overlay)
    }
    
    private func tintedImage(with tintColor: UIColor, blendMode: CGBlendMode) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    /// 垂直翻转
    func verticalOverturn() -> UIImage {
        let srcImage = self
        //翻转图片的方向
        var flipImageOrientation = (srcImage.imageOrientation.rawValue + 4) % 8
        flipImageOrientation += flipImageOrientation%2==0 ? 1 : -1
        //翻转图片
        let flipImage =  UIImage(cgImage:srcImage.cgImage!,
                                 scale:srcImage.scale,
                                 orientation:UIImage.Orientation(rawValue: flipImageOrientation)!
        )
        return flipImage
    }
    /// 水平翻转
    func horizontalOverturn() -> UIImage {
        let srcImage = self
        //翻转图片的方向
        let flipImageOrientation = (srcImage.imageOrientation.rawValue + 4) % 8
        //翻转图片
        let flipImage =  UIImage(cgImage:srcImage.cgImage!,
                                 scale:srcImage.scale,
                                 orientation:UIImage.Orientation(rawValue: flipImageOrientation)!
        )
        return flipImage
    }
    
    //根据颜色获取image
    class func imageWithColor(with color: UIColor, size : CGSize) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    //根据view绘图
    class func getImageFromView(view:UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
