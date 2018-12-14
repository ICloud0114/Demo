//
//  TBResetPasswordCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBResetPasswordCmd.h"

@implementation TBResetPasswordCmd

+ (instancetype)instanceWithAccount:(NSString *)account {
    TBResetPasswordCmd *cmd = [self cmdInstance];
    if (isPhoneNumber(account)) {
        cmd.phone = account;
    } else {
        cmd.email = account;
    }
    return cmd;
}

- (NSInteger)cmd {
    return 32;
}

- (NSDictionary *)payload {
    if (self.phone) { [sendValue setObject:self.phone forKey:@"phone"]; }
    if (self.email) { [sendValue setObject:self.email forKey:@"email"]; }
    [sendValue setObject:self.code forKey:@"code"];
    [sendValue setObject:self.password forKey:@"password"];
    return sendValue;
}

- (BOOL)loginIfNeed {
    return NO;
}

@end
