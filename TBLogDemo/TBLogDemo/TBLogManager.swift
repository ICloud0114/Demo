//
//  TBLogManager.swift
//  TBLogDemo
//
//  Created by ICloud on 2018/11/12.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class TBLogManager: NSObject {
    static let `default` = TBLogManager()
    
    override init() {
        
    }
    
    func Log<T>(level: LogLevel,message: T) {
        #if DEBUG
        print(message)
        #endif
        
    }
}
