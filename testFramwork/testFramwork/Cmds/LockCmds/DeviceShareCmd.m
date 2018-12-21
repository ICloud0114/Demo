//
//  DeviceShareCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "DeviceShareCmd.h"

@implementation DeviceShareCmd

+ (instancetype)instanceWithInviteAccount:(NSString *)iAccount {
    DeviceShareCmd *cmd = [DeviceShareCmd cmdInstance];
    if (isPhoneNumber(iAccount)) {
        cmd.iPhone = iAccount;
    } else {
        cmd.iEmail = iAccount;
    }
    return cmd;
}

- (NSInteger)cmd {
    return TOPBAND_CMD_DINVITE;
}

- (NSDictionary *)payload {
    if (self.iPhone) { [sendValue setObject:self.iPhone forKey:@"phone"]; }
    if (self.iEmail) { [sendValue setObject:self.iEmail forKey:@"email"]; }
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    return sendValue;
}
@end
