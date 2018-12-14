//
//  TBDeviceUserBind+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/29.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDeviceUserBind+TableCoding.h"

@implementation TBDeviceUserBind (TableCoding)

+ (NSString *)tableName {
    return @"d_device_user_bind";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "user_id TEXT,"
                     "device_id TEXT,"
                     "creator TEXT,"
                     "family_id TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:
                           @"INSERT INTO %@ (id,uid,user_id,device_id,creator,family_id,create_time,update_time,del_flag) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@',%d)",
                           [[self class] tableName],
                           self.id,
                           self.uid,
                           self.userId,
                           self.deviceId,
                           self.creator,
                           self.familyId,
                           self.createTime,
                           self.updateTime,
                           self.delFlag];
    return [db executeUpdate:insertSql];
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}
//@"UPDATE %@ SET is_valid = %d where userId = '%@'"
+ (BOOL)deleteWithUserId:(NSString *)userId deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET del_flag = 1 WHERE user_id = '%@' AND device_id = '%@'", [self tableName], userId, deviceId];
    return executeUpdate(sql);
}
@end
