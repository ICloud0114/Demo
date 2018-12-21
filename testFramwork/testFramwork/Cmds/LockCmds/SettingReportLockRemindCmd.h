//
//  SettingReportLockRemindCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//
//设置开门上报提醒功能



NS_ASSUME_NONNULL_BEGIN
@interface SettingReportLockRemindCmd : TBBaseCmd

@property (nonatomic, copy) NSString *deviceId; //设备id
@property (nonatomic, assign) BOOL open; //是否打开开门提醒

@end
NS_ASSUME_NONNULL_END
