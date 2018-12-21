//
//  ModifyLockUserNicknameCmd.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "ModifyLockUserNicknameCmd.h"

@implementation ModifyLockUserNicknameCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_UPLOAD_LOCK_USER_NAME;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.uid forKey:@"uid"];
    [sendValue setObject:@(self.lockUserId) forKey:@"lockUserId"];
    [sendValue setObject:self.nickname forKey:@"nickName"];
    return sendValue;
}
@end
