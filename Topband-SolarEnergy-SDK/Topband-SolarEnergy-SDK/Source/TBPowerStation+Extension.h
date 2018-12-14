//
//  TBPowerStation+Extension.h
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBPowerStation.h"
#import <Topband_Cloud_Device/TBDevice.h>
#import <tSmartSDK/tSmartSDK.h>

//统计粒度
typedef NS_ENUM(NSInteger, TBPowerStationDataStatisticsFineness) {
    kStatisticsFinenessMonth = 1,
    kStatisticsFinenessYear = 2,
    kStatisticsFinenessAll = 3
};

NS_ASSUME_NONNULL_BEGIN
@class TBPowerStationRealData;
@class TBStatisticsDataModel;
@interface TBPowerStation (Extension)

//电站下的设备
- (NSArray<TBDevice *> *)powerStationDevices;

- (void)queryPowerStationRealDataWithInverterId:(NSString * _Nullable)iId time:(NSString *)time completion:(void (^)(TBReponseStatus, TBPowerStationRealData * _Nullable))handler;

- (void)queryPowerStationStatisticsDataWithINverterId:(NSString * _Nullable)iId
                                                 time:(NSString * _Nullable)time
                                                 type:(TBPowerStationDataStatisticsFineness)fineness
                                           completion:(void (^)(TBReponseStatus, NSArray<TBStatisticsDataModel *> * _Nullable))hanlder;
@end
NS_ASSUME_NONNULL_END
