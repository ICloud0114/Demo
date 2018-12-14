//
//  TBDeviceProperty.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//
//设备属性表

#import <Foundation/Foundation.h>

@interface TBDeviceProperty : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int electricity;
@property (nonatomic, assign) int online;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, assign) int resetFlag;

@property (nonatomic, copy) NSString *fieldExt; //属性扩展,json格式

@property (nonatomic, assign) int signal;
@property (nonatomic, assign) double longitude; //经度
@property (nonatomic, assign) double latitude; //纬度
@property (nonatomic, assign) int status; //状态
@property (nonatomic, assign) int rent; //租赁标识，1-租赁
@end

