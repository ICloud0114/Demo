//
//  UnbindDeviceCmd.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/5.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "UnbindDeviceCmd.h"

@implementation UnbindDeviceCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_AUDD;
}

- (NSDictionary *)payload {
    return sendValue;
}

@end
