//
//  GetCardUsersCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "GetCardUsersCmd.h"

@implementation GetCardUsersCmd
- (NSInteger)cmd {
    return TOPBAND_CMD_GFCU;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    return sendValue;
}
@end
