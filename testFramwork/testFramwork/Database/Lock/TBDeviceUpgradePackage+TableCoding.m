//
//  TBDeviceUpgradePackage+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/12/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBDeviceUpgradePackage+TableCoding.h"

@implementation TBDeviceUpgradePackage (TableCoding)
+ (NSString *)tableName {
    return @"d_device_upgrade_package";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "upgrade_package_id TEXT,"
                     "product_id TEXT,"
                     "device_id TEXT,"
                     "name TEXT,"
                     "version_no INTEGER,"
                     "package_type INTEGER,"
                     "original_file_name TEXT,"
                     "file_size INTEGER,"
                     "file_md5 TEXT,"
                     "file_path TEXT,"
                     "upgrade_time TEXT,"
                     "create_by TEXT,"
                     "desc TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:
                           @"INSERT INTO %@ (id, upgrade_package_id, product_id, device_id, name, version_no, package_type, original_file_name, file_size, file_md5, file_path, upgrade_time, create_by, desc, create_time,update_time,del_flag) VALUES ('%@', '%@', '%@', '%@', '%@', '%d', '%d', '%@', '%f', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%d')",
                           [[self class] tableName],
                           self.id,
                           self.upgradePackageId,
                           self.productId,
                           self.deviceId,
                           self.name,
                           self.version_no,
                           self.packageType,
                           self.originalFileName,
                           self.fileSize,
                           self.fileMd5,
                           self.filePath,
                           self.upgradeTime,
                           self.createBy,
                           self.desc,
                           self.createTime,
                           self.updateTime,
                           self.delFlag];
    
    return [db executeUpdate:insertSql];
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}
@end
