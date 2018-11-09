//
//  TBLog.swift
//  TBLogDemo
//
//  Created by ICloud on 2018/11/9.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import Foundation

func Log<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)\n\(method):\(line) ->📝\(message)")
    #endif
}
