//
//  TBFamilyUser.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

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
