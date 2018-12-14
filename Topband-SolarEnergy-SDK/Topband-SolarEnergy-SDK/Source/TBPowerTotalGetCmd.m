//
//  PowerTotalGetCmd.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/1/17.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerTotalGetCmd.h"

@implementation TBPowerTotalGetCmd

- (NSInteger)cmd {
    return 23;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.stationId forKey:@"stationId"];
    if (self.deviceId) {
        [sendValue setObject:self.deviceId forKey:@"deviceId"];
    }
    [sendValue setObject:@(self.type) forKey:@"type"];
    if (self.time) {
        [sendValue setObject:self.time forKey:@"time"];
    }
    return sendValue;
}

@end
