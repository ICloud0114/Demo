//
//  DeleteLockUserCmd.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/5.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "DeleteLockUserCmd.h"

@implementation DeleteLockUserCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_DU;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"userId"];
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    return sendValue;
}

@end
