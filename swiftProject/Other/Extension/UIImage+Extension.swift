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
    
    static func fixImageToUpOrientation(_ image: UIImage) -> UIImage? {
        guard image.imageOrientation != .up, let cgImage = image.cgImage else {
            return nil
        }
        var transform = CGAffineTransform.identity
        switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: 180.0)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: 90.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -90.0)//-90.0
        default:
            break
        }
        
        switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        
        let ctx = CGContext.init(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)
        
        ctx?.concatenate(transform)
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
        default:
            ctx?.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        
        guard let fiexedCGImage = ctx?.makeImage() else {return nil}
        return UIImage(cgImage: fiexedCGImage)
    }
    func fixedImageToUpOrientation2() -> UIImage {
        guard self.imageOrientation != .up, let cgImage = self.cgImage else {
            return self
        }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2)//-90.0
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        
        let ctx = CGContext.init(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)
        
        ctx?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        default:
            ctx?.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        }
        
        guard let fiexedCGImage = ctx?.makeImage() else {return self}
        return UIImage(cgImage: fiexedCGImage)
    }
    func fixedImageToUpOrientation1() -> UIImage {
        guard self.imageOrientation != .up, let imgRef = self.cgImage else {
            return self
        }
        let maxResolution = ScreenWidth
        let width = CGFloat(imgRef.width)
        let height = CGFloat(imgRef.height)
        
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        var scaleRatio : CGFloat = 1
        if (width > maxResolution || height > maxResolution) {
            
            scaleRatio = min(maxResolution / bounds.size.width, maxResolution / bounds.size.height)
            bounds.size.height = bounds.size.height * scaleRatio
            bounds.size.width = bounds.size.width * scaleRatio
        }
        
        var transform = CGAffineTransform.identity
        let orient = self.imageOrientation
        let imageSize = CGSize(width: width, height: height)
        
        
        switch(orient) {
        case .up :
            break
            
        case .upMirrored :
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .down :
            
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            transform = transform.rotated(by: 90)
            
        case .downMirrored :
            
            transform = CGAffineTransform(translationX: 0, y: imageSize.height)
            
            transform = transform.scaledBy(x: 1, y: -1)
            
        case .left :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            
            transform = CGAffineTransform(translationX: 0, y: imageSize.width)
            transform = transform.rotated(by: 270)
        case .leftMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = storedHeight
            
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
            
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: 270)
            
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight
            
            transform = CGAffineTransform(translationX: imageSize.height, y: 0)
            transform = transform.rotated(by: 90)
            
        case .rightMirrored :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by: 90)
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        
        if orient == .right || orient == .left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: -height, y: 0)
        } else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: -height)
        }
        context?.concatenate(transform)
        UIGraphicsGetCurrentContext()?.draw(imgRef, in: CGRect (x: 0, y: 0, width: width, height: height))
        
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageCopy ?? self;
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
    
    //垂直翻转
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
    //水平翻转
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
