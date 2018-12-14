//
//  TBDeviceUserBind.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/29.
//  Copyright © 2017年 topband. All rights reserved.
//
//用户设备关系绑定表

#import <Foundation/Foundation.h>

@interface TBDeviceUserBind : NSObject

@property (nonatomic, copy) NSString *id;//主键
@property (nonatomic, copy) NSString *uid; //设备uid
@property (nonatomic, copy) NSString *userId; //用户id
@property (nonatomic, copy) NSString *deviceId; //设备Id
@property (nonatomic, copy) NSString *creator; //创建者
@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) int delFlag;

@end
