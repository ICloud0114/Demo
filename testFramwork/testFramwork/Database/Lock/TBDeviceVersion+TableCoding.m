//
//  TBDeviceVersion+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/12/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBDeviceVersion+TableCoding.h"

@implementation TBDeviceVersion (TableCoding)
+ (NSString *)tableName {
    return @"d_device_version";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "device_id TEXT,"
                     "product_id TEXT,"
                     "type INTEGER,"
                     "version TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:
                           @"INSERT INTO %@ (id, device_id, product_id, type, version, create_time,update_time,del_flag) VALUES ('%@', '%@', '%@', '%d', '%@', '%@', '%@', %d)",
                           [[self class] tableName],
                           self.id,
                           self.deviceId,
                           self.productId,
                           self.type,
                           self.version,
                           self.createTime,
                           self.updateTime,
                           self.delFlag];
    
    return [db executeUpdate:insertSql];
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}
@end
