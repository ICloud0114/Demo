//
//  ResetPasswordCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "ResetPasswordCmd.h"

@implementation ResetPasswordCmd

+ (instancetype)instanceWithAccount:(NSString *)account {
    ResetPasswordCmd *cmd = [self cmdInstance];
    if (isPhoneNumber(account)) {
        cmd.phone = account;
    } else {
        cmd.email = account;
    }
    return cmd;
}

- (NSInteger)cmd {
    return TOPBAND_CMD_RESETPASSWORD;
}

- (NSDictionary *)payload {
    if (self.phone) { [sendValue setObject:self.phone forKey:@"phone"]; }
    if (self.email) { [sendValue setObject:self.email forKey:@"email"]; }
    [sendValue setObject:self.code forKey:@"code"];
    [sendValue setObject:self.password forKey:@"password"];
    return sendValue;
}

@end
