//
//  BindFamilyCardCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "BindFamilyCardCmd.h"

@implementation BindFamilyCardCmd
- (NSInteger)cmd {
    return TOPBAND_CMD_BFC;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.uid forKey:@"uid"];
    [sendValue setObject:self.deviceName forKey:@"deviceName"];
    [sendValue setObject:@(self.checkOnline) forKey:@"checkOnline"];
    return sendValue;
}
@end
