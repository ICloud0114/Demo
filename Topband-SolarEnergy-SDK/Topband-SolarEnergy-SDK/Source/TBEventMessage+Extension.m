//
//  TBEventMessage+Extension.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBEventMessage+Extension.h"
#import <TBDataBase/TBDatabaseManager.h>
#import <MJExtension/MJExtension.h>
#import <Topband_Cloud_TBUser/TBUser.h>

#import "TBEventMessage+TableCoding.h"
#import <Topband_Cloud_Device/TBDevice+TableCoding.h>
#import <Topband_Cloud_Device/TBGateway+TableCoding.h>
#import "TBPowerStationGateway+TableCoding.h"
#import "TBPowerStationAccount+TableCoding.h"

@implementation TBEventMessage (Extension)
static int pSize = 15;
+ (void)setPageSize:(int)pageSize {
    pSize = pageSize;
}

+ (int)pageSize {
    return pSize;
}

- (BOOL)readMsg {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET read_status = 1 WHERE id = '%@'", [TBEventMessage tableName], self.id];
    if (executeUpdate(sql)) {
        self.readStatus = 1;
    }
    return NO;
}

+ (NSArray<TBEventMessage *> *)readEventMessagesWithPageIndex:(int)pageIndex {
    NSAssert([NSThread currentThread].isMainThread, @"not main thread call");
    int pageSize = self.pageSize;
    NSString *userId = [TBUser shareInstance].userId;
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT "
                     "id,"
                     "uid,"
                     "device_id AS deviceId,"
                     "type,"
                     "time,"
                     "message,"
                     "read_type AS readType,"
                     "update_time AS updateTime,"
                     "create_time AS createTime,"
                     "del_flag AS delFlag,"
                     "device_event_id AS deviceEventId,"
                     "read_status AS readStatus "
                     "FROM %@ WHERE del_flag = 0 AND " //事件表
                     "device_id IN ("
                         "SELECT id FROM %@ WHERE gateway_uid IN (" //设备表
                             "SELECT uid FROM %@ WHERE id IN ("  //设备网关表
                                 "SELECT gateway_id FROM %@ WHERE power_station_id IN (" //电站网关表
                                     "SELECT power_station_id FROM %@ WHERE account_id = '%@' AND del_flag = 0" //电站账号绑定表
                                 ")"
                             ")"
                         ")"
                     ") "
                     "ORDER BY time DESC "
                     "LIMIT %d OFFSET %d"
                     ,
                     [TBEventMessage tableName],
                     [TBDevice tableName],
                     [TBGateway tableName],
                     [TBPowerStationGateway tableName],
                     [TBPowerStationAccount tableName],
                     userId,
                     pageSize,
                     pageSize * pageIndex];
    NSMutableArray *eventMessages = @[].mutableCopy;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            NSDictionary *dic = [set resultDictionary];
            TBEventMessage *eventMsg = [TBEventMessage mj_objectWithKeyValues:dic];
            [eventMessages addObject:eventMsg];
        }
        [set close];
    }
    return eventMessages;
}
@end
