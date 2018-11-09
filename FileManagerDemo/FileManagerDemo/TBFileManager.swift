//
//  TBFileManager.swift
//  Mower
//
//  Created by ICloud on 2018/7/10.
//  Copyright © 2018年 Topband. All rights reserved.
//

import Foundation

let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/ca"

let cachePathUrl = URL(fileURLWithPath: cachePath)

/**
  创建文件
 */
func creatNewFiles(filePath: String) -> Bool{
    
    let manager = FileManager.default
    
    try? manager.createDirectory(at: cachePathUrl, withIntermediateDirectories: true, attributes: nil)
    
    let exist = manager.fileExists(atPath: filePath)
    if !exist {
      let result = manager.createFile(atPath: filePath, contents: nil, attributes: nil)
        manager.createFile(atPath: filePath, contents: Data(), attributes: nil)
        return result
    }else{
        return true
    }
}

/**
 读取文件
 
 - parameter name:        文件名
 - parameter fileBaseUrl: url
 
 - returns: 读取数据
 */
func readTheFlies(name:String , fileBaseUrl:NSURL) ->NSString{
    let file = fileBaseUrl.appendingPathComponent(name)
    let readHandler = try! FileHandle(forReadingFrom: file!)
    let data = readHandler.readDataToEndOfFile()
    let readString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    return readString!
}

func pathForDirectoryCache(name: String) -> String{
    let manager = FileManager.default
    let urlForCatch = manager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
    let url = urlForCatch.first! as NSURL
    
    return url.appendingPathComponent("ca/" + name)!.absoluteString
}
