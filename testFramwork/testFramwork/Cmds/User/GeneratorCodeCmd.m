//
//  GeneratorCodeCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "GeneratorCodeCmd.h"

@interface GeneratorCodeCmd()

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;

@end

@implementation GeneratorCodeCmd

+ (instancetype)instanceGeneratorCodeCmdWithEmail:(NSString *)email {
    GeneratorCodeCmd *cmd = [GeneratorCodeCmd cmdInstance];
    cmd.email = email;
    return cmd;
}

+ (instancetype)instanceGeneratorCodeCmdWithPhone:(NSString *)phone {
    GeneratorCodeCmd *cmd = [GeneratorCodeCmd cmdInstance];
    cmd.phone = phone;
    return cmd;
}

- (NSInteger)cmd {
    return TOPBAND_CMD_GC;
}

- (NSDictionary *)payload {
    if (self.phone) { [sendValue setObject:self.phone forKey:@"phone"]; }
    if (self.email) { [sendValue setObject:self.email forKey:@"email"]; }
    [sendValue setObject:@(self.type) forKey:@"type"];
    return sendValue;
}

@end
