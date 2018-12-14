//
//  TBGateway.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//
//网关表

#import <Foundation/Foundation.h>

@interface TBGateway : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *uploadUser;
@property (nonatomic, assign) int activatedState;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) int online;
@property (nonatomic, assign) int workStatus;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int timezone;

@end
