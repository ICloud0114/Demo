//
//  PowerStation.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBPowerStation : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;  //电站名称
@property (nonatomic, assign) double coverArea; //覆盖面积
@property (nonatomic, copy) NSString *companyId; //公司ID
@property (nonatomic, assign) int countryId; //国家ID
@property (nonatomic, assign) int provinceId; //省份ID
@property (nonatomic, assign) int cityId; //城市ID
@property (nonatomic, copy) NSString *address; //详细地址(不包括国家/省/市).
@property (nonatomic, copy) NSString *detailAddress; //详细地址(国家 + 省 + 市 + address).
@property (nonatomic, copy) NSString *accountId; //所属用户ID. 来自u_account表的id.
@property (nonatomic, assign) int status; //状态. 1: 正常; 2: 报废.
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) double powerTotal;
@property (nonatomic, assign) long powerTime;
@property (nonatomic, copy) NSString *monitorId;
@property (nonatomic, copy) NSString *startTimePoint; //每天电站数据上报的开始时间,图表统计时,以该时间为时间轴的起点.
@property (nonatomic, copy) NSString *endTimePoint; //每天电站数据上报的结束时间,图表统计时,以该时间为时间轴的终点.

@property (nonatomic, assign) BOOL isAbnormal; //记录电站是否异常
@end
