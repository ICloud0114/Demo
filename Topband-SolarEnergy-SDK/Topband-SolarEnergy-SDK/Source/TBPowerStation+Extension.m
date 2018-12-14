//
//  TBPowerStation+Extension.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBPowerStation+Extension.h"
#import <Topband_Cloud_Device/TBDeviceManager.h>
#import <Topband_Cloud_Device/TBGateway+TableCoding.h>
#import <MJExtension/MJExtension.h>

#import "TBPowerStationGateway+TableCoding.h"
#import "TBPowerRateGetCmd.h"
#import "TBPowerTotalGetCmd.h"
#import "TBPowerStationRealData.h"
#import "TBStatisticsDataModel.h"

@implementation TBPowerStation (Extension)

- (NSArray<TBDevice *> *)powerStationDevices {
    NSString *whereCondition = [NSString stringWithFormat:
                                @"gateway_uid IN "
                                "(SELECT uid FROM %@ WHERE id IN "
                                    "(SELECT gateway_id FROM %@ WHERE power_station_id = '%@' AND del_flag = 0)"
                                ")",
                                [TBGateway tableName],
                                [TBPowerStationGateway tableName],
                                self.id];
    return [[TBDeviceManager share] deviceListWithWhereCondition: whereCondition];
}

- (void)queryPowerStationRealDataWithInverterId:(NSString *)iId
                                           time:(NSString *)time
                                     completion:(void (^)(TBReponseStatus, TBPowerStationRealData * _Nullable))handler {
    TBPowerRateGetCmd *cmd = [TBPowerRateGetCmd cmdInstance];
    cmd.stationId = self.id;
    cmd.deviceId = nil;
    cmd.time = time;
    sendCmd(cmd, ^(TBResponse * _Nonnull response) {
        if (response.status == TBStatusSuccess) {
            [TBStatisticsDataModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"point": @"point"
                         };
            }];
            TBPowerStationRealData *realData = [TBPowerStationRealData mj_objectWithKeyValues:response.result];
            handler(TBStatusSuccess, realData);
        } else {
            handler(response.status, nil);
        }
    });
}

- (void)queryPowerStationStatisticsDataWithINverterId:(NSString *)iId
                                                 time:(NSString *)time
                                                 type:(TBPowerStationDataStatisticsFineness)fineness
                                           completion:(void (^)(TBReponseStatus, NSArray<TBStatisticsDataModel *> * _Nullable))hanlder {
    TBPowerTotalGetCmd *cmd = [TBPowerTotalGetCmd cmdInstance];
    cmd.stationId = self.id;
    cmd.deviceId = iId;
    cmd.time = time;
    cmd.type = fineness;
    sendCmd(cmd, ^(TBResponse * _Nonnull response) {
        if (response.status == TBStatusSuccess) {
            NSMutableArray<TBStatisticsDataModel *> *ary = @[].mutableCopy;
            [TBStatisticsDataModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"point": @"time"
                         };
            }];
            for (NSDictionary *dic in response.result[@"data"]) {
                [ary addObject:[TBStatisticsDataModel mj_objectWithKeyValues:dic]];
            }
            hanlder(TBStatusSuccess, ary);
        } else {
            hanlder(response.status, nil);
        }
    });
}

@end
