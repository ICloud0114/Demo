//
//  TBLogManager.swift
//  TBLogDemo
//
//  Created by ICloud on 2018/11/12.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

class TBLogManager: NSObject {
    static let `default` = TBLogManager()
    let fm = FileManager()
    var lastModifyLogIndex = 1
    let logPath = docPath + "/Logs"
    let fileSizeLimit: UInt64 = 1024 * 250
    var currentLogFilePath: String{
       return logPath + "/log" + "\(lastModifyLogIndex)"
    }
    
    override init() {
        super.init()
        initLogPath()
    }
    
    func Log<T>(level: LogLevel,message: T) {
        #if DEBUG
        print(message)
        #endif
        DispatchQueue.global().sync {
            _ = self.log2FileMessage(message as! String)
        }
        
    }
    
    func initLogPath(){
        touch(logPath)
    }
    
    
    func log2FileMessage(_ msg: String) -> Bool {
        
        guard let fd = shouldWriteFile() else {
            NSLog("open log file failed.")
            return false
        }
        
        fputs(UnsafePointer<Int8>(msg), fd)
        fputs("\r\n",fd)
        fflush(fd)
        fclose(fd)
        return true
    }
    
    func shouldWriteFile() -> UnsafeMutablePointer<FILE>?{
        do {
            let exist = fm.fileExists(atPath: self.currentLogFilePath)
            
            if !exist{
                return fopen(self.currentLogFilePath, "a+")
            }
            
            let fileAtt = try fm.attributesOfItem(atPath: self.currentLogFilePath) as NSDictionary
            let fz = fileAtt.fileSize()
            if fz > fileSizeLimit
            {
                if (lastModifyLogIndex == 20) {
                    lastModifyLogIndex = 1
                }
                else{
                    lastModifyLogIndex += 1
                }
                return fopen(self.currentLogFilePath, "w+")
            }
            else{
                return  fopen(self.currentLogFilePath, "a+")
            }
        } catch _ {
            return nil
        }
    }
    
    func touch(_ path: String) {
        
        if !fm.fileExists(atPath: path){
            do {
                _ = try fm.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch _ {}
        }
        lastModifyLogIndex = findLastModifyLogIndex()
    }
    
    func findLastModifyLogIndex() -> Int {
        
        let lastFilePath = findLastModifyFileInPath(logPath)
        if lastFilePath != nil{
            let fileName = lastFilePath!.components(separatedBy: "/").last
            guard let name = fileName else{
                return 1
            }
            let index = name.suffix(from: (name.index(name.startIndex, offsetBy: 3)))
            return Int(index)!
        }
        return 1;
    }
    
    func findLastModifyFileInPath(_ path: String) -> String?{

        do {
            let paths = try fm.contentsOfDirectory(atPath: logPath)
            let sortPath = paths.sorted { (p1, p2) -> Bool in
                
                do{
                    let att1 = try fm.attributesOfItem(atPath: logPath + "/" + p1) as NSDictionary
                    let att2 = try fm.attributesOfItem(atPath: logPath + "/" + p2) as NSDictionary
                    return att1.fileModificationDate()! < att2.fileModificationDate()!
                }catch _{
                    return false
                }
            }
            return sortPath.last
        } catch _ {
            return nil
        }
    }
}
