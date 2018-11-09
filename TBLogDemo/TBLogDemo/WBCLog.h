//
//  WBCLog.h
//  KuaiChong
//
//  Created by Onliu on 14-6-8.
//  Copyright (c) 2014年 Onliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBCLogMacros.h"

@interface WBCLog : NSObject
+(instancetype)sharedInstance;

@property (nonatomic,assign) WBCLog_LEVEL levelTrigger;
@property (nonatomic,assign) NSInteger logCountLimit;
@property (nonatomic,assign) long long logSizeLimit;

-(void)Log:(WBCLog_LEVEL) level message:(NSString *)msg classObject:(id)classObj file:(const char *)file function:(const char *)func line:(const unsigned int)line;
- (void)processException:(NSException *)exception;
@end
