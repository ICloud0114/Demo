//
//  ModifyUserNicknameCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/26.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "ModifyUserNicknameCmd.h"

@implementation ModifyUserNicknameCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_SN;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"uid"];
    [sendValue setObject:self.nickname forKey:@"nickName"];
    return sendValue;
}

@end
