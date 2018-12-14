//
//  PowerStation+TableCoding.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/18.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBPowerStation+TableCoding.h"

@implementation TBPowerStation (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "name TEXT,"
                     "cover_area REAL,"
                     "company_id TEXT,"
                     "country_id INTEGER,"
                     "province_id INTEGER,"
                     "city_id INTEGER,"
                     "address TEXT,"
                     "detail_address TEXT,"
                     "account_id TEXT,"
                     "status INTEGER,"
                     "del_flag INTEGER,"
                     "create_by TEXT,"
                     "update_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "power_total REAL,"
                     "power_time INTEGER,"
                     "monitor_id TEXT,"
                     "start_time_point TEXT,"
                     "end_time_point TEXT,"
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
                     "(id,"
                     "name,"
                     "cover_area,"
                     "company_id,"
                     "country_id,"
                     "province_id,"
                     "city_id,"
                     "address,"
                     "detail_address,"
                     "account_id,"
                     "status,"
                     "del_flag,"
                     "create_by,"
                     "update_by,"
                     "create_time,"
                     "update_time,"
                     "power_total,"
                     "power_time,"
                     "monitor_id,"
                     "start_time_point,"
                     "end_time_point) "
                     "VALUES "
                     "('%@'," //id
                     "'%@'," //name
                     "%lf," //cover_area
                     "'%@'," //company_id
                     "%d," //country_id
                     "%d," //province_id
                     "%d," //city_id
                     "'%@'," //address
                     "'%@'," //detail_address
                     "'%@'," //account_id
                     "%d," //status
                     "%d," //del_flag
                     "'%@'," //create_by
                     "'%@'," //update_by
                     "'%@'," //create_time
                     "'%@'," //update_time
                     "%lf," //power_total
                     "%ld," //power_time
                     "'%@'," //monitor_id
                     "'%@'," //start_time_point
                     "'%@')", //end_time_point
                     [[self class] tableName],
                     self.id,
                     self.name,
                     self.coverArea,
                     self.companyId,
                     self.countryId,
                     self.provinceId,
                     self.cityId,
                     self.address,
                     self.detailAddress,
                     self.accountId,
                     self.status,
                     self.delFlag,
                     self.createBy,
                     self.updateBy,
                     self.createTime,
                     self.updateTime,
                     self.powerTotal,
                     self.powerTime,
                     self.monitorId,
                     self.startTimePoint,
                     self.endTimePoint];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"t_power_station";
}

@end
