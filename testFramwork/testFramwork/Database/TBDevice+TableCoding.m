//
//  TBDevice+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/27.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDevice+TableCoding.h"
#import "MJExtension.h"

@implementation TBDevice (TableCoding)

//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    return [propertyName mj_underlineFromCamel];
//}

+ (NSString *)tableName {
    return @"d_device";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS "
                     "%@ (id TEXT,"
                     "device_no TEXT,"
                     "gateway_uid TEXT,"
                     "ext_addr TEXT,"
                     "endpoint INTEGER,"
                     "device_name TEXT,"
                     "device_type INTEGER,"
                     "sub_device_type INTEGER,"
                     "company_id TEXT,"
                     "model TEXT,"
                     "version TEXT,"
                     "start_time TEXT,"
//                     "work_status INTEGER,"
                     "del_flag INTEGER,"
                     "create_by TEXT,"
                     "update_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "product_id TEXT,"
                     "UNIQUE(id) ON CONFLICT REPLACE)", [self tableName]];
    executeUpdate(sql);
    return [self createTrigger];
}

//为设备表创建一个触发器，当设备表一条数据被删除时候，自动删除与设备表相关的数据
+ (BOOL)createTrigger {
    executeUpdate(@"DROP TRIGGER IF EXISTS delete_device");
    NSString *createTriggerSql = [NSString stringWithFormat:
                                  @"CREATE TRIGGER IF NOT EXISTS delete_device BEFORE DELETE on %@ FOR EACH ROW"
                                  " BEGIN "
                                  //删除设备用户绑定表
                                  "DELETE FROM d_device_user_bind WHERE device_id = OLD.id; "
                                  "DELETE FROM d_device_fields WHERE device_id = OLD.id;"
                                  " END",
                                  [self tableName]];
    return executeUpdate(createTriggerSql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ "
                     "("
                         "id,"
                         "device_no,"
                         "gateway_uid,"
                         "ext_addr,"
                         "endpoint,"
                         "device_name,"
                         "device_type,"
                         "sub_device_type,"
                         "company_id,"
                         "model,"
                         "version,"
                         "start_time,"
//                         "work_status,"
                         "del_flag,"
                         "create_by,"
                         "update_by,"
                         "create_time,"
                         "update_time,"
                         "product_id"
                     ") "
                     "VALUES "
                     "("
                         "'%@',"
                         "'%@',"
                         "'%@',"
                         "'%@',"
                         "%d,"
                         "'%@',"
                         "%d,"
                         "%d,"
                         "'%@',"
                         "'%@',"
                         "'%@',"
                         "'%@',"
//                         "%d,"
                         "%d,"
                         "'%@',"
                         "'%@',"
                         "'%@',"
                         "'%@',"
                         "'%@'"
                     ")",
                     [[self class] tableName],
                     self.id,
                     self.deviceNo,
                     self.gatewayUid,
                     self.extAddr,
                     self.endpoint,
                     self.deviceName,
                     self.deviceType,
                     self.subDeviceType,
                     self.companyId,
                     self.model,
                     self.version,
                     self.startTime,
//                     self.workStatus,
                     self.delFlag,
                     self.createBy,
                     self.updateBy,
                     self.createTime,
                     self.updateTime,
                     self.productId];
    return sql;
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (BOOL)updateName:(NSString *)name forDevice:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET device_name = '%@' WHERE id = '%@'", [self tableName], name, deviceId];
    return executeUpdate(sql);
}

+ (BOOL)deleteWithDeviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = '%@'", [self tableName], deviceId];
    return executeUpdate(sql);
}

+ (BOOL)deleteWithDeviceUid:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE gateway_uid = '%@'", [self tableName], uid];
    return executeUpdate(sql);
}

+ (NSDictionary *)allDeviceNameValuesAndDeviceIdKey {
    NSString *sql = [NSString stringWithFormat:@"select id AS deviceId, device_name AS deviceName from %@", [self tableName]];
    NSMutableDictionary *dic = @{}.mutableCopy;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            [dic setObject:[set stringForColumn:@"deviceName"] forKey:[set stringForColumn:@"deviceId"]];
        }
        [set close];
    }
    return dic;
}

+ (NSString *)deviceIdWithUid:(NSString *)uid {
    NSAssert([NSThread currentThread].isMainThread, @"请在主线程调用");
    NSString *sql = [NSString stringWithFormat:@"SELECT id FROM %@ WHERE gateway_uid = '%@'", [self tableName], uid];
    __block NSString *deviceId = @"";
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        deviceId = [rs stringForColumn:@"id"];
    });
    return deviceId;
}
@end
