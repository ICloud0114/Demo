//
//  UpdateCardPhoneCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "UpdateCardPhoneCmd.h"

@implementation UpdateCardPhoneCmd
- (NSInteger)cmd {
    return TOPBAND_CMD_UDFCP;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    [sendValue setObject:self.phone forKey:@"phone"];
    [sendValue setObject:self.phoneName forKey:@"phoneName"];
    return sendValue;
}
@end
