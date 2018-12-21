//
//  CheckSMSCodeCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "CheckSMSCodeCmd.h"

@implementation CheckSMSCodeCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_GC;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.phone forKey:@"phone"];
    [sendValue setObject:self.code forKey:@"code"];
    return sendValue;
}

@end
