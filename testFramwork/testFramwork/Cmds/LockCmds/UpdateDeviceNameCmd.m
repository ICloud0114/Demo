//
//  UpdateDeviceNameCmd.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "UpdateDeviceNameCmd.h"

@implementation UpdateDeviceNameCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_UDN;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    [sendValue setObject:self.deviceName forKey:@"deviceName"];
    return sendValue;
}

@end
