//
//  TBPowerStationRealData.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TBStatisticsDataModel;
@interface TBPowerStationRealData : NSObject

@property (nonatomic, copy) NSArray<TBStatisticsDataModel *> *sunshine; //太阳辐射
@property (nonatomic, copy) NSArray<TBStatisticsDataModel *> *power; //功率

@end
NS_ASSUME_NONNULL_END
