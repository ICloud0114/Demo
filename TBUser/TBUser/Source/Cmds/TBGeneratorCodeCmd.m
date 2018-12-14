//
//  TBGeneratorCodeCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBGeneratorCodeCmd.h"

@interface TBGeneratorCodeCmd()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;

@end

@implementation TBGeneratorCodeCmd

+ (instancetype)instanceGeneratorCodeCmdWithEmail:(NSString *)email {
    TBGeneratorCodeCmd *cmd = [TBGeneratorCodeCmd cmdInstance];
    cmd.email = email;
    return cmd;
}

+ (instancetype)instanceGeneratorCodeCmdWithPhone:(NSString *)phone {
    TBGeneratorCodeCmd *cmd = [TBGeneratorCodeCmd cmdInstance];
    cmd.phone = phone;
    return cmd;
}

- (NSInteger)cmd {
    return 30;
}

- (NSDictionary *)payload {
    if (self.phone) { [sendValue setObject:self.phone forKey:@"phone"]; }
    if (self.email) { [sendValue setObject:self.email forKey:@"email"]; }
    [sendValue setObject:@(self.type) forKey:@"type"];
    return sendValue;
}

- (BOOL)loginIfNeed {
    return NO;
}

@end
