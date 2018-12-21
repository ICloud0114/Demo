//
//  TBDeviceProperty+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDeviceProperty+TableCoding.h"
#import "MJExtension.h"

@implementation TBDeviceProperty (TableCoding)

//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    return [propertyName mj_underlineFromCamel];
//}

+ (NSString *)tableName {
    return @"d_device_fields";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "device_id TEXT,"
                     "uid TEXT,"
                     "electricity INTEGER,"
                     "online INTEGER,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "field_ext TEXT,"
                     "reset_flag INTEGER,"
                     "signal INTEGER,"
                     "longitude REAL,"
                     "latitude REAL,"
                     "status INTEGER,"
                     "rent INTEGER,"
                     "UNIQUE(id,device_id) ON CONFLICT REPLACE)", [self tableName]];
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (id,device_id,uid,electricity,online,create_time,update_time,del_flag,field_ext,reset_flag,signal,longitude,latitude,status,rent) VALUES ('%@','%@','%@',%d,%d,'%@','%@',%d,'%@',%d,%d,%lf,%lf,%d,%d)",
                     [[self class] tableName],
                     self.id,
                     self.deviceId,
                     self.uid,
                     self.electricity,
                     self.online,
                     self.createTime,
                     self.updateTime,
                     self.delFlag,
                     self.fieldExt,
                     self.resetFlag,
                     self.signal,
                     self.longitude,
                     self.latitude,
                     self.status,
                     self.rent];
    return sql;
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

@end

