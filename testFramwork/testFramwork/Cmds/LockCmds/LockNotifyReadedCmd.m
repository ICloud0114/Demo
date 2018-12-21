//
//  LockNotifyReadedCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/31.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "LockNotifyReadedCmd.h"

@implementation LockNotifyReadedCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_READED_MESSAGE_NUM;
}

- (NSDictionary *)payload {
    [sendValue setObject:@(self.num) forKey:@"num"];
    [sendValue setObject:self.phoneToken forKey:@"phoneToken"];
    return sendValue;
}
@end
