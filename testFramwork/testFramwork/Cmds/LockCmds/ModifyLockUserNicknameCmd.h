//
//  ModifyLockUserNicknameCmd.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//


@interface ModifyLockUserNicknameCmd : TBBaseCmd

//@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int lockUserId;
@property (nonatomic, copy) NSString *nickname;

@end
