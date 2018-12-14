//
//  TBSolarEnergyTables.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBSolarEnergyTables.h"
#import <Topband_Cloud_TBUser/TBAccount+TableCoding.h>
#import <Topband_Cloud_TBUser/TBLocalAccount+TableCoding.h>
#import <TBDataBase/TBDatabaseVersion+TableCoding.h>
#import <Topband_Cloud_Device/TBDevice+TableCoding.h>
#import <Topband_Cloud_Device/TBGateway+TableCoding.h>
#import <Topband_Cloud_Device/TBDeviceUserBind+TableCoding.h>
#import <Topband_Cloud_Device/TBDeviceProperty+TableCoding.h>
#import <Topband_Cloud_Device/TBDeviceDataPoint+TableCoding.h>

#import "TBSysUser+TableCoding.h"
#import "TBEventMessage+TableCoding.h"
#import "TBNotice+TableCoding.h"
#import "TBPowerStation+TableCoding.h"
#import "TBPowerStationGateway+TableCoding.h"
#import "TBPowerStationAccount+TableCoding.h"

@implementation TBSolarEnergyTables

//服务器表
+ (NSArray<Class<TBTableCoding>> *)serverTables {
    return @[
             [TBDevice class],
             [TBGateway class],
             [TBDeviceUserBind class],
             [TBDeviceProperty class],
             [TBDeviceDataPoint class],
             [TBSysUser class],
             [TBEventMessage class],
             [TBNotice class],
             [TBPowerStation class],
             [TBPowerStationGateway class],
             [TBPowerStationAccount class]
             ];
}

//本地表
+ (NSArray<Class<TBTableCoding>> *)localTables {
    return @[
             [TBDatabaseVersion class],
             [TBAccount class],
             [TBLocalAccount class]
             ];
}

@end
