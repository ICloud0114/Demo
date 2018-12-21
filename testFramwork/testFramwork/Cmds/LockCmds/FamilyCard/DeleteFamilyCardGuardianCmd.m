//
//  DeleteFamilyCardGuardianCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "DeleteFamilyCardGuardianCmd.h"

@implementation DeleteFamilyCardGuardianCmd
- (NSInteger)cmd {
    return TOPBAND_CMD_DFCP;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    [sendValue setObject:self.phone forKey:@"phone"];
    return sendValue;
}
@end
