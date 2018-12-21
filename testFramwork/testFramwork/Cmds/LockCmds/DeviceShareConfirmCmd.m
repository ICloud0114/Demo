//
//  DeviceShareConfirmCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "DeviceShareConfirmCmd.h"

@implementation DeviceShareConfirmCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_DHC;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.inviteId forKey:@"inviteId"];
    [sendValue setObject:@(self.type) forKey:@"type"];
    return sendValue;
}

@end
