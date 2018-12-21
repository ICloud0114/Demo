//
//  SettingReportLockRemindCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "SettingReportLockRemindCmd.h"

@implementation SettingReportLockRemindCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_RLR;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    [sendValue setObject:self.open? @0: @1 forKey:@"type"];
    return sendValue;
}

@end
