//
//  RequestTemporaryPasswordCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/26.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "RequestTemporaryPasswordCmd.h"

@implementation RequestTemporaryPasswordCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_GTP;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    [sendValue setObject:@(self.type) forKey:@"type"];
    if (self.startTime) [sendValue setObject:self.startTime forKey:@"startTime"];
    if (self.endTime) [sendValue setObject:self.endTime forKey:@"endTime"];
    [sendValue setObject:self.phone forKey:@"phone"];
    [sendValue setObject:self.requestTime forKey:@"requestTime"];
    if (self.nickName) {
        [sendValue setObject:self.nickName forKey:@"nickName"];
    }
    return sendValue;
}

@end
