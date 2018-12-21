//
//  UpdateShareUserNickname.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//


@interface UpdateShareUserNickname : TBBaseCmd

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickName;

@end
