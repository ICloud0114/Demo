//
//  TBMessage+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/3.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBMessage+TableCoding.h"

@implementation TBMessage (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "user_id TEXT,"
                     "family_id TEXT,"
                     "device_id TEXT,"
                     "text TEXT,"
                     "time TEXT,"
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
                     @"INSERT INTO %@ (id,uid,user_id,family_id,device_id,text,time,create_time,update_time,del_flag) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@',%d)",
                     [[self class] tableName],
                     self.id,
                     self.uid,
                     self.userId,
                     self.familyId,
                     self.deviceId,
                     self.text,
                     self.time,
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
    return @"t_message";
}

+ (NSString *)maxUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(update_time) FROM %@ WHERE user_id = '%@'", [[self class] tableName], userId];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MAX(update_time)"];
    });
    return maxUpdateTime;
}

+ (NSString *)minUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(update_time) FROM %@ WHERE user_id = '%@'", [[self class] tableName], userId];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MIN(update_time)"];
    });
    return maxUpdateTime;
}
+ (BOOL)cleanAllData {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",[[self class] tableName]];
    return executeUpdate(sql);
}

@end
