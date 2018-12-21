//
//  Tables.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "Tables.h"
#import "TBLocalAccount+TableCoding.h"
#import "TBAccount+TableCoding.h"
#import "TBDevice+TableCoding.h"
#import "TBDeviceProperty+TableCoding.h"
#import "TBGateway+TableCoding.h"

#import "TBMessagePushSetting+TableCoding.h"
#import "TBDeviceUserBind+TableCoding.h"
#import "TBMessage+TableCoding.h"
#import "TBOpenLockRecord+TableCoding.h"
#import "TBLockUser+TableCoding.h"
#import "TBFamilyUser+TableCoding.h"
//#import "TBUpgradePackage+TableCoding.h"
//#import "TBDeviceUpgradeTask+TableCoding.h"
#import "TBDeviceVersion+TableCoding.h"
#import "TBDeviceUpgradePackage+TableCoding.h"

@implementation Tables
//服务器表
+ (NSArray<Class<TableCoding>> *)serverTables {
    return @[
             [TBDevice class],
             [TBDeviceProperty class],
             [TBGateway class],
             [TBMessagePushSetting class],
             [TBDeviceUserBind class],
             [TBMessage class],
             [TBOpenLockRecord class],
             [TBLockUser class],
             [TBFamilyUser class],
//             [TBUpgradePackage class],
//             [TBDeviceUpgradeTask class],
             [TBDeviceVersion class],
             [TBDeviceUpgradePackage class]
             ];
}
//本地表
+ (NSArray<Class<TableCoding>> *)localTables {
    return @[[TBLocalAccount class],
             [TBAccount class],
             [TBDatabaseVersion class]
             ];
}
@end
