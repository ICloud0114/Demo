//
//  TBRegisterAccountCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBRegisterAccountCmd.h"


@interface TBRegisterAccountCmd()
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@end

@implementation TBRegisterAccountCmd

- (NSInteger)cmd {
    return 31;
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
    TBRegisterAccountCmd *cmd = [self cmdInstance];
    if (isPhoneNumber(account)) {
        cmd.phone = account;
        cmd.checkEmailCode = NO;
    } else {
        cmd.email = account;
    }
    return cmd;
}

- (BOOL)loginIfNeed {
    return NO;
}

@end
