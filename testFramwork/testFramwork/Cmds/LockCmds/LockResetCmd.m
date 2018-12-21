//
//  LockResetCmd.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/2/25.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "LockResetCmd.h"

@implementation LockResetCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_LOCK_RESET;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.resettingId forKey:@"resettingId"];
    return sendValue;
}

@end
