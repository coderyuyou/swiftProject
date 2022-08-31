//
//  FileManager+Extension.swift
//  swiftProject
//
//  Created by yuyou on 2022/8/31.
//  Copyright © 2022 SuperYu. All rights reserved.
//

import Foundation

/// 单位
typealias MB = Double
/// 文件类型判定
enum FileType: Int {
    case txt = 0
    case json = 1
    case image = 2
    case folder = 3
    case unknown = 4
    case audio = 5
    case mp4 = 6
    case ttf = 7
    case otf = 8
}

extension FileManager {
    /// 判定文件类型
    static func fileType(filePath: String) -> FileType {
        let tmpPath = filePath
        guard !directoryIsExists(path: tmpPath) else {
            return FileType.folder
        }
        if tmpPath.hasSuffix(".json") {
            return FileType.json
        } else if tmpPath.hasSuffix(".txt") {
            return FileType.txt
        } else if tmpPath.hasSuffix(".png") || tmpPath.hasSuffix(".jpg") {
            return FileType.image
        } else if tmpPath.hasSuffix(".mp4") {
            return FileType.mp4
        } else if tmpPath.hasSuffix(".aac") {
            return FileType.audio
        } else if tmpPath.lowercased().hasSuffix(".ttf") {
            return FileType.ttf
        } else if tmpPath.lowercased().hasSuffix(".otf") {
            return FileType.otf
        }
        return FileType.unknown
    }

    /// 单个获取文件大小
    /// - Parameter filePath: 单个文件路径
    /// - Returns: MB单位
    static func fileSize(at filePath: String) throws -> MB {
        let manager = FileManager.default
        guard manager.fileExists(atPath: filePath) else {
            return 0.0
        }
        let attrib = try manager.attributesOfItem(atPath: filePath)
        let filesize = Double((attrib as NSDictionary).fileSize())
        return filesize / 1024 / 1024
    }

    /// 递归获取文件夹的所有文件大小
    /// - Parameter atPath: 指定文件夹目录
    /// - Returns: MB 单位的大小
    static func folderSize(atPath: String) throws -> MB {
        guard directoryIsExists(path: atPath) else {
            return 0.0
        }
        let fileManager = FileManager.default
        guard let subPaths = fileManager.subpaths(atPath: atPath) else {
            return 0.00
        }
        var sizeValue: MB = 0.00
        for subPath in subPaths {
            // 如果是文件则直接相架文件大小，否则递归获取文件夹下面的数据
            let subfullPath = atPath.appendingPath(path: subPath)
            // 只计算文件大小，文件夹忽略
            if FileManager.isFile(path: subfullPath) {
                sizeValue += try fileSize(at: subfullPath)
            }
        }
        return sizeValue
    }

    ///  判定文件夹是否存在
    /// - Parameter path:  文件夹路径
    /// - Returns:  true 存在，false 不存在
    static func directoryIsExists(path: String) -> Bool {
        var directoryExists = ObjCBool(false)
        let fileExists = FileManager.default.fileExists(atPath: path, isDirectory: &directoryExists)
        return fileExists && directoryExists.boolValue
    }

    ///  判定是否是文件
    /// - Parameter path:  路径
    /// - Returns:  true  表示文件
    static func isFile(path: String) -> Bool {
        var directoryExists = ObjCBool(false)
        let fileExists = FileManager.default.fileExists(atPath: path, isDirectory: &directoryExists)
        return fileExists && (directoryExists.boolValue == false)
    }

    static func createDirectory(atPath: String) {
        try? FileManager.default.createDirectory(atPath: atPath, withIntermediateDirectories: true, attributes: [:])
    }
    
    static func createFolder(folderName: String) throws -> URL? {
        let filemanager = FileManager.default
        guard let documentDict = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let folderUrl = documentDict.appendingPathComponent(folderName)
        guard !filemanager.fileExists(atPath: folderUrl.path) else {
            return nil
        }
        try filemanager.createDirectory(atPath: folderUrl.path, withIntermediateDirectories: true, attributes: nil)
        
        return folderUrl
    }

    /// 文件夹内容替换 新文件夹内容复制到老的文件夹中，保留老文件夹名字
    static func replaceResourceFile(path: String, newPath: String) throws {
        let fileManager = FileManager.default
        // 查看文件是否存在,如果已存在
        if fileManager.fileExists(atPath: path) {
            try fileManager.removeItem(atPath: path)
        }
        try fileManager.copyItem(atPath: newPath, toPath: path)
    }

    /// 文件copy,包括整个文件目录
    /// - Parameters:
    ///   - atPath: 原路径
    ///   - toPath: 目标目录，如果存在，则强制删除覆盖
    static func copyFile(atPath: String, toPath: String) throws {
        let managerDefault = FileManager.default
        // 2.查看文件是否存在,如果已存在，先删除
        if managerDefault.fileExists(atPath: toPath) {
            try removeFile(atPath: toPath)
        }
        try managerDefault.copyItem(atPath: atPath, toPath: toPath)
    }

    ///  删除指定文件
    /// - Parameter atPath:  目标文件
    static func removeFile(atPath: String) throws {
        try self.default.removeItem(atPath: atPath)
    }

    /// 空余磁盘容量大小，单位MB
    /// - Returns:  空余磁盘容量大小，单位MB
    static func diskFreeSize() -> MB? {
        guard let dicValue = try? FileManager.default.attributesOfFileSystem(forPath: YYDirectory.documentPath),
              let freeSize = dicValue[FileAttributeKey.systemFreeSize] as? NSNumber else {
            return nil
        }
        let freeSizeMB = Float64(freeSize.uint64Value) / 1024.0 / 1024.0
        return MB(freeSizeMB)
    }

    ///  总磁盘大小，单位MB
    /// - Returns:  单位MB
    static func diskTotalSize() -> MB? {
        guard let dicValue = try? FileManager.default.attributesOfFileSystem(forPath: YYDirectory.documentPath),
              let totalSize = dicValue[FileAttributeKey.systemSize] as? NSNumber else {
            return nil
        }

        let sizeMB = Float64(totalSize.uint64Value) / 1024.0 / 1024.0
        return MB(sizeMB)
    }
}
