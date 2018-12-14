//
//  TBPowerStationManager.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerStationManager.h"
#import "TBPowerStation.h"
#import <Topband_Cloud_TBUser/TBUser.h>
#import <MJExtension/MJExtension.h>
#import <TBDataBase/TBDatabaseManager.h>

@implementation TBPowerStationManager

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static TBPowerStationManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [TBPowerStationManager new];
    });
    return manager;
}

- (NSArray<TBPowerStation *> *)powerStations {
    NSString *userId = [TBUser shareInstance].userId;
    return [self loadAllPowerStationsWithUserId:userId];
}

#pragma mark - Query
- (NSArray<TBPowerStation *> *)loadAllPowerStationsWithUserId:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT "
                     "id,"
                     "name,"
                     "cover_area AS coverArea,"
                     "company_id AS companyId,"
                     "country_id AS countryId,"
                     "province_id AS provinceId,"
                     "city_id AS cityId,"
                     "detail_address AS address,"
                     "power_time AS powerTime,"
                     "power_total AS powerTotal "
                     "FROM "
                     "t_power_station "
                     "WHERE "
                     "account_id = '%@' AND del_flag = 0"
                     , userId];
    NSMutableArray *powerSations = @[].mutableCopy;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            NSDictionary *dic = [set resultDictionary];
            TBPowerStation *powerStation = [TBPowerStation mj_objectWithKeyValues:dic];
            powerStation.isAbnormal = [TBPowerStationManager lookUpIsContaionAbnormalForPowerStationId:powerStation.id];
            [powerSations addObject:powerStation];
        }
        [set close];
    }
    return powerSations;
}

+ (BOOL)lookUpIsContaionAbnormalForPowerStationId:(NSString *)powerStationId {
    DLog([NSString stringWithFormat:@"lookUpIsContaionAbnormalAbnormal开始时间戳: %lf", CFAbsoluteTimeGetCurrent()]);
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT "
                     "online "
                     "FROM "
                     "d_device_fields "
                     "WHERE device_id IN "
                     "(select d_device.id from (d_device inner join d_gateway on d_device.gateway_uid = d_gateway.uid) inner join t_power_station_gateway on d_gateway.id = t_power_station_gateway.gateway_id and t_power_station_gateway.power_station_id = '%@')",
                     powerStationId];
    __block BOOL isContaionAbnormal = NO;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            if ([set intForColumn:@"online"] == 0) {
                isContaionAbnormal = YES;
                break;
            }
        }
        [set close];
    }
    DLog([NSString stringWithFormat:@"lookUpIsContaionAbnormalAbnormal结束时间戳: %lf", CFAbsoluteTimeGetCurrent()]);
    return isContaionAbnormal;
}

@end
