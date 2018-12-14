//
//  TBPowerStationManager.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//
//电站管理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TBPowerStation;
@interface TBPowerStationManager : NSObject

+ (instancetype)share;

@property (nonatomic, copy, readonly) NSArray<TBPowerStation *> *powerStations;
@end
NS_ASSUME_NONNULL_END
