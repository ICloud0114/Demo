//
//  ModifyUserAccountCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/27.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "ModifyUserAccountCmd.h"

@implementation ModifyUserAccountCmd

+ (instancetype)instanceWithNewAccount:(NSString *)nAccount {
    ModifyUserAccountCmd *cmd = [ModifyUserAccountCmd cmdInstance];
    if (isPhoneNumber(nAccount)) {
        cmd.nPhone = nAccount;
        cmd.checkEmailCode = NO;
    } else {
        cmd.nEmail = nAccount;
    }
    return cmd;
}

- (NSInteger)cmd {
    return TOPBAND_CMD_AMOA;
}

- (NSDictionary *)payload {
    if (self.nPhone) {
        [sendValue setObject:self.nPhone forKey:@"phone"];
        [sendValue setObject:self.code forKey:@"code"];
    }
    if (self.nEmail) {
        [sendValue setObject:self.nEmail forKey:@"email"];
        if (self.checkEmailCode) {
            [sendValue setObject:self.code forKey:@"code"];
        }
        [sendValue setObject:self.checkEmailCode ? @1: @0 forKey:@"checkEmail"];
    }
    [sendValue setObject:self.password forKey:@"password"];
    return sendValue;
}
@end
