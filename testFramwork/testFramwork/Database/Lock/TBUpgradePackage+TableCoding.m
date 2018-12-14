//
//  TBDeviceUpgradePackage+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBUpgradePackage+TableCoding.h"

@implementation TBUpgradePackage (TableCoding)
+ (NSString *)tableName {
    return @"t_upgrade_package";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "name TEXT,"
                     "version_no INTEGER,"
                     "product_id TEXT,"
                     "device_id TEXT,"
                     "package_type INTEGER,"
                     "original_file_name TEXT,"
                     "file_size INTEGER,"
                     "file_md5 TEXT,"
                     "file_path TEXT,"
                     "upgrade_time TEXT,"
                     "remarks TEXT,"
                     "create_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:
                           @"INSERT INTO %@ (id, name, version_no, product_id, device_id,package_type, original_file_name, file_size, file_md5, file_path, upgrade_time, remarks, create_by, create_time,update_time,del_flag) VALUES ('%@', '%@', '%d', '%@', '%@', '%d', '%@', '%f', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %d)",
                           [[self class] tableName],
                           self.id,
                           self.name,
                           self.version_no,
                           self.productId,
                           self.deviceId,
                           self.packageType,
                           self.originalFileName,
                           self.fileSize,
                           self.fileMd5,
                           self.filePath,
                           self.upgradeTime,
                           self.remarks,
                           self.createBy,
                           self.createTime,
                           self.updateTime,
                           self.delFlag];
    
    return [db executeUpdate:insertSql];
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

//+ (BOOL)deleteWithUserId:(NSString *)userId deviceId:(NSString *)deviceId {
//    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET del_flag = 1 WHERE user_id = '%@' AND device_id = '%@'", [self tableName], userId, deviceId];
//    return executeUpdate(sql);
//}
@end
