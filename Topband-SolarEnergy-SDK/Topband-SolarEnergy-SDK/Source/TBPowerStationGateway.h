//
//  PowerStationGateway.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//
//电站网关
#import <Foundation/Foundation.h>

@interface TBPowerStationGateway : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *powerStationId;
@property (nonatomic, copy) NSString *gatewayId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;

@end
