//
//  TBLockUser.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/8.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLockUser : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int lockUserId;
@property (nonatomic, assign) int userType;
@property (nonatomic, assign) int keyType;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *startTime; //密码有效开始时间
@property (nonatomic, copy) NSString *endTime; //密码有效结束时间
@property (nonatomic, copy) NSString *passwordId; //密码ID

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *subUserId;

@property (nonatomic, copy) NSString *nickName;
@end
