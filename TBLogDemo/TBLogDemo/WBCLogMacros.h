//
//  WBCLogMacros.h
//  KuaiChong
//
//  Created by Onliu on 14-6-8.
//  Copyright (c) 2014年 Onliu. All rights reserved.
//

#ifndef KuaiChong_WBCLogMacros_h
#define KuaiChong_WBCLogMacros_h

typedef NS_ENUM(NSInteger, WBCLog_LEVEL) {
    WBCLog_LEVEL_DEBUG=1,
    WBCLog_LEVEL_INFO,
    WBCLog_LEVEL_WARN,
    WBCLog_LEVEL_ERROR,
    WBCLog_LEVEL_FATAL,
    WBCLog_LEVEL_NONE
};

#define WBCLog_LEVEL_STRING_DEBUG    @"1"
#define WBCLog_LEVEL_STRING_INFO     @"2"
#define WBCLog_LEVEL_STRING_WARN     @"3"
#define WBCLog_LEVEL_STRING_ERROR    @"4"
#define WBCLog_LEVEL_STRING_FATAL    @"5"
#define WBCLog_LEVEL_STRING_NONE     @"6"

#define WBCLogDebug(format, ...) \
[[WBCLog sharedInstance] Log:WBCLog_LEVEL_DEBUG message:[NSString stringWithFormat:format, ##__VA_ARGS__]\
classObject:self file:__FILE__ function:__FUNCTION__ line:__LINE__]

#define WBCLogInfo(format, ...) \
[[WBCLog sharedInstance] Log:WBCLog_LEVEL_INFO message:[NSString stringWithFormat:format, ##__VA_ARGS__]\
classObject:self file:__FILE__ function:__FUNCTION__ line:__LINE__]

#define WBCLogWarn(format, ...) \
[[WBCLog sharedInstance] Log:WBCLog_LEVEL_WARN message:[NSString stringWithFormat:format, ##__VA_ARGS__]\
classObject:self file:__FILE__ function:__FUNCTION__ line:__LINE__]

#define WBCLogError(format, ...) \
[[WBCLog sharedInstance] Log:WBCLog_LEVEL_ERROR message:[NSString stringWithFormat:format, ##__VA_ARGS__]\
classObject:self file:__FILE__ function:__FUNCTION__ line:__LINE__]

#define WBCLogFatal(format, ...) \
[[WBCLog sharedInstance] Log:WBCLog_LEVEL_FATAL message:[NSString stringWithFormat:format, ##__VA_ARGS__]\
classObject:self file:__FILE__ function:__FUNCTION__ line:__LINE__]

#endif
