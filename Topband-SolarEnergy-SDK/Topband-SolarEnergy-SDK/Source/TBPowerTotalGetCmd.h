//
//  PowerTotalGetCmd.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/1/17.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBPowerTotalGetCmd : TBBaseCmd

@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, nullable, copy) NSString *deviceId;
@property (nonatomic, assign) int type; ///1-月，2-年，3-总
@property (nonatomic, copy) NSString *time; //当type=1时，time=yyyyMM;  type=2时，time=yyyy, type=3时，time 为空

@end
NS_ASSUME_NONNULL_END
