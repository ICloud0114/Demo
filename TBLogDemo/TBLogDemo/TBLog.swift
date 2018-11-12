//
//  TBLog.swift
//  TBLogDemo
//
//  Created by ICloud on 2018/11/9.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import Foundation

enum LogLevel {
    case DEBUG //调试模式
    case INFO  //信息日志
    case WARN  //警告日志
    case ERROR //错误日志
    case FATAL //致命日志
    case NONE  //无
}

func Log_Debug<T>(msg: T, file: String = #file, method: String = #function, line: Int = #line){
    let msg = "\((file as NSString).lastPathComponent)\n\(Date()) \(method):\(line) ->📝\(msg)"
    TBLogManager.default.Log(level: .DEBUG, message: msg)
}

func Log_Info<T>(msg: T, file: String = #file, method: String = #function, line: Int = #line){
    let msg = "\((file as NSString).lastPathComponent)\n\(Date()) \(method):\(line) ->📝\(msg)"
    TBLogManager.default.Log(level: .INFO, message: msg)
}
