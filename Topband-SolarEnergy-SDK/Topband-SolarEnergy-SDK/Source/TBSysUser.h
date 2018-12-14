//
//  TBSysUser.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/1/22.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBSysUser : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *salt;
@property (nonatomic, assign) int userType;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *telephone2;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;

@end
