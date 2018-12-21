//
//  UpdateShareUserNickname.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "UpdateShareUserNickname.h"

@implementation UpdateShareUserNickname

- (NSInteger)cmd {
    return TOPBAND_CMD_USUN;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"userId"];
    [sendValue setObject:self.uid forKey:@"uid"];
    [sendValue setObject:self.nickName forKey:@"nickName"];
    return sendValue;
}

@end
