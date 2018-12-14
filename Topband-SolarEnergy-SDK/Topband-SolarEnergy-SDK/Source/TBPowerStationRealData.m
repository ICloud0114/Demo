//
//  TBPowerStationRealData.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerStationRealData.h"
#import "MJExtension.h"

@implementation TBPowerStationRealData

+ (void)initialize {
    [super initialize];
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"power": @"TBStatisticsDataModel",
                 @"sunshine": @"TBStatisticsDataModel"
                 };
    }];
}

@end
