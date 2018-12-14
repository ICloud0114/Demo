//
//  TBDevice.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/27.
//  Copyright © 2017年 topband. All rights reserved.
//
//设备表

#import <Foundation/Foundation.h>

@interface TBDevice : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *deviceNo;
@property (nonatomic, copy) NSString *gatewayUid;
@property (nonatomic, copy) NSString *extAddr;
@property (nonatomic, assign) int endpoint;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, assign) int deviceType;
@property (nonatomic, assign) int subDeviceType;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *startTime;
//@property (nonatomic, assign) int workStatus;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *productId;
@end
