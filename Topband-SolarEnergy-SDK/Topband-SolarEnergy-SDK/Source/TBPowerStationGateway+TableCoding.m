//
//  PowerStationGateway+TableCoding.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerStationGateway+TableCoding.h"

@implementation TBPowerStationGateway (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "power_station_id TEXT,"
                     "gateway_id TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ "
                     "(id, power_station_id, gateway_id, create_time, update_time, del_flag) "
                     "VALUES "
                     "('%@', '%@', '%@', '%@', '%@', %d)",
                     [[self class] tableName],
                     self.id,
                     self.powerStationId,
                     self.gatewayId,
                     self.createTime,
                     self.updateTime,
                     self.delFlag];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"t_power_station_gateway";
}

@end
