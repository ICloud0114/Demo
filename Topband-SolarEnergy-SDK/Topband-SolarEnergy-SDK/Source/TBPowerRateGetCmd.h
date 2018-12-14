//
//  PowerRateGetCmd.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/17.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBPowerRateGetCmd : TBBaseCmd

@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, nullable, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *time; //yyyyMMdd

@end
NS_ASSUME_NONNULL_END
