//
//  PowerRateGetCmd.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/17.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerRateGetCmd.h"

@implementation TBPowerRateGetCmd

- (NSInteger)cmd {
    return 22;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.stationId forKey:@"stationId"];
    if (self.deviceId) {
        [sendValue setObject:self.deviceId forKey:@"deviceId"];
    }
    [sendValue setObject:self.time forKey:@"time"];
    return sendValue;
}

@end
