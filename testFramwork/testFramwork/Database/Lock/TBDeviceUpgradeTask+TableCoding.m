//
//  TBDeviceUpgradeTask+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBDeviceUpgradeTask+TableCoding.h"

@implementation TBDeviceUpgradeTask (TableCoding)
+ (NSString *)tableName {
    return @"d_device_upgrade_task";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "upgrade_package_id TEXT,"
                     "uid TEXT,"
                     "device_id TEXT,"
                     "upgrade_type INTEGER,"
                     "start_version TEXT,"
                     "end_version TEXT,"
                     "product_id TEXT,"
                     "status INTEGER,"
                     "code TEXT,"
                     "create_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(device_id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:
                           @"INSERT INTO %@ (id,upgrade_package_id,uid,device_id,upgrade_type,start_version,end_version,product_id,status,code,create_by,create_time,update_time,del_flag) VALUES ('%@','%@','%@','%@','%d','%@','%@','%@','%d','%@','%@','%@','%@',%d)",
                           [[self class] tableName],
                           self.id,
                           self.upgradePackageId,
                           self.uid,
                           self.deviceId,
                           self.upgradeType,
                           self.startVersion,
                           self.endVersion,
                           self.productId,
                           self.status,
                           self.code,
                           self.createBy,
                           self.createTime,
                           self.updateTime,
                           self.delFlag];
    return [db executeUpdate:insertSql];
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

+ (BOOL)deleteWithUserId:(NSString *)userId deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET del_flag = 1 WHERE user_id = '%@' AND device_id = '%@'", [self tableName], userId, deviceId];
    return executeUpdate(sql);
}
@end
