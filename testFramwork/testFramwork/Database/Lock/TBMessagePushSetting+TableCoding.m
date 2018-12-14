//
//  TBMessagePushSetting+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBMessagePushSetting+TableCoding.h"

@implementation TBMessagePushSetting (TableCoding)

+ (NSString *)tableName {
    return @"t_message_push_setting";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "user_id TEXT,"
                     "type INTEGER,"
                     "uid TEXT,"
                     "push_flag INTEGER,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "start_time TEXT,"
                     "end_time TEXT,"
                     "weak INTEGER,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ "
                     "(id,user_id,type,uid,push_flag,create_time,update_time,del_flag,start_time,end_time,weak)"
                     " VALUES ('%@','%@',%d,'%@',%d,'%@','%@',%d,'%@','%@',%d)",
                     [[self class] tableName],
                     self.id,
                     self.userId,
                     self.type,
                     self.uid,
                     self.pushFlag,
                     self.createTime,
                     self.updateTime,
                     self.delFlag,
                     self.startTime,
                     self.endTime,
                     self.weak];
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

