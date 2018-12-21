//
//  BindLockCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "BindLockCmd.h"

@implementation BindLockCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_BD;
}

- (NSDictionary *)payload {
    return sendValue;
}

@end
