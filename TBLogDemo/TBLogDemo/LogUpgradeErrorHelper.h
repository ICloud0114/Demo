//
//  LogUpgradeErrorHelper.h
//  ScmClient
//
//  Created by kevin on 17/2/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, LogType) {
    LogTypeInfo = 1 << 0,
    LogTypeError = 1 << 1,
    LogTypeWarning = 1 << 2,
    LogTypeDebug = 1 << 3,
    LogTypeReport = 1 << 4,
    LogTypeIgnore = 1 << 5  // release版本 不会写入日志文件中
};

@interface LogUpgradeErrorHelper : NSObject

+ (instancetype)sharedInstance;

- (void)writeLog:(NSString *)log type:(LogType)type;

@end
