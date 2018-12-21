//
//  ModifyPasswordCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/15.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "ModifyPasswordCmd.h"

@implementation ModifyPasswordCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_MP;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"uid"];
    [sendValue setObject:self.oPassword forKey:@"oldPassword"];
    [sendValue setObject:self.nPassword forKey:@"newPassword"];
    return sendValue;
}

@end
