//
//  TBOpenLockRecord.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/3.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBOpenLockRecord : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *lockUserId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;

@property (nonatomic, copy) NSString *subUserId;

@property (nonatomic, copy) NSString *nickName;

@end
