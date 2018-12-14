//
//  TBFamilyUser.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

//id    varchar(32)
//family_id    varchar(32)    家庭Id
//user_id    varchar(32)    用户Id
//user_type    int(11)    0:管理员 1: 非管理员
//nick_name_in_family    varchar(100)
//create_time    datetime
//update_time    datetime
//uid     varchar(36)
//del_flag    int(11)

@interface TBFamilyUser : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) int userType;
@property (nonatomic, copy) NSString *nickNameInFamily;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int delFlag;

@end
