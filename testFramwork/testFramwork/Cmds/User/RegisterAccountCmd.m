//
//  RegisterAccountCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "RegisterAccountCmd.h"

@interface RegisterAccountCmd()
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@end

@implementation RegisterAccountCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_RST;
}

- (NSDictionary *)payload {
    if (self.phone) {
        [sendValue setObject:self.phone forKey:@"phone"];
        [sendValue setObject:self.code forKey:@"code"];
    }
    if (self.email) {
        [sendValue setObject:self.email forKey:@"email"];
        if (self.checkEmailCode) {
            [sendValue setObject:self.code forKey:@"code"];
        }
        [sendValue setObject:self.checkEmailCode ? @1: @0 forKey:@"checkEmail"];
    }
    [sendValue setObject:self.password forKey:@"password"];
    return sendValue;
}

+ (instancetype)instanceWithAccount:(NSString *)account {
    RegisterAccountCmd *cmd = [self cmdInstance];
    if (isPhoneNumber(account)) {
        cmd.phone = account;
        cmd.checkEmailCode = NO;
    } else {
        cmd.email = account;
    }
    return cmd;
}

@end
