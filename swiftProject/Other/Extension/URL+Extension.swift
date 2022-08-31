//
//  URL+Extension.swift
//  swiftProject
//
//  Created by yuyou on 2022/8/31.
//  Copyright © 2022 SuperYu. All rights reserved.
//

import UIKit
import AVFoundation

extension URL {
    
    /// 是否可用
    var isAudioAvaliable: Bool {
        let asset = AVURLAsset(url: self)
        let state = !asset.tracks(withMediaType: .audio).isEmpty
        return state
    }
    
    /// 视频第一张缩略图
    /// - Returns: 返回第一张缩略图
    func firstThumbnail() -> UIImage? {
        return thumbnail(fromTime: 0.0)
    }
    
    /// 视频最后一张缩略图
    /// - Returns: 返回最后一张缩略图
    func lastThumbnail() -> UIImage? {
        let timeValue = AVAsset(url: self).duration
        let secondValue = Float64(timeValue.value) / Float64(timeValue.timescale)
        return thumbnail(fromTime: secondValue)
    }
    
    /// 指定UR L获取根据时间获取指定的截屏信息
    /// - Parameter time: 时间单位：秒，eg :1.2s
    /// - maxSize: 指定缩略图大小，特别是高清视频的时候，每一帧的图片大小太大
    /// - Returns: 返回指定的截屏信息
    func thumbnail(fromTime time: Float64 = 0, maxSize: CGSize = CGSize.zero) -> UIImage? {
        let imageGener = AVAssetImageGenerator(asset: AVAsset(url: self))
        imageGener.appliesPreferredTrackTransform = true
        imageGener.requestedTimeToleranceAfter = .zero
        imageGener.requestedTimeToleranceBefore = .zero
        if maxSize != .zero {
            imageGener.maximumSize = maxSize
        }
        let timeValue = CMTimeMakeWithSeconds(time, preferredTimescale: 600)
        var actualTime = CMTimeMake(value: 0, timescale: 0)
        
        guard let cgImg = try? imageGener.copyCGImage(at: timeValue, actualTime: &actualTime) else {
            return nil
        }
        
        return UIImage(cgImage: cgImg)
    }
    
    /// 获取指定时间缩略图数组
    /// - Parameter times: 时间数组(单位为s)
    /// - maxSize ： 每一帧图片的大小，高清视频的时候需要使用到，否则不如4K视频一帧会有32M 大小
    /// - Returns: 所有缩略图组合
    func thumbnails(fromTimes times: [TimeInterval], maxSize: CGSize = CGSize.zero) -> [UIImage] {
        var imageArray: [UIImage] = []
        
        let imageGener = AVAssetImageGenerator(asset: AVAsset(url: self))
        imageGener.appliesPreferredTrackTransform = true
        imageGener.requestedTimeToleranceAfter = .zero
        imageGener.requestedTimeToleranceBefore = .zero
        if maxSize != .zero {
            imageGener.maximumSize = maxSize
        }
        
        let timeArray = times.map {
            NSValue(time: CMTimeMakeWithSeconds($0, preferredTimescale: 600))
        }
        
        // 使用同步等待获取图片信息
        let dispatchGroup = DispatchGroup()
        
        // 开始记录进入group 的次数
        for _ in 0 ..< timeArray.count {
            dispatchGroup.enter()
        }
        imageGener.generateCGImagesAsynchronously(forTimes: timeArray) { _, cgImage, _, res, _ in
            defer {
                dispatchGroup.leave()
            }
            guard res == .succeeded, let cgImage = cgImage else {
                return
            }
            imageArray.append(UIImage(cgImage: cgImage))
        }
        // 设置超时时间为1.0 s
        _ = dispatchGroup.wait(timeout: DispatchTime.now() + 3.0)
        
        return imageArray
    }
}
