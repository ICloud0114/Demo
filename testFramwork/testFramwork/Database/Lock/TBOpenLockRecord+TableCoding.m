//
//  TBOpenLockRecord+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/3.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBOpenLockRecord+TableCoding.h"

@implementation TBOpenLockRecord (TableCoding)
+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "user_id TEXT,"
                     "lock_user_id TEXT,"
                     "type TEXT,"
                     "time TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "del_flag INTEGER,"
                     "sub_user_id TEXT,"
                     "nick_name TEXT,"
                     "UNIQUE(id) ON CONFLICT REPLACE)",
                     [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ (id,uid,user_id,lock_user_id,type,time,create_time,update_time,del_flag,sub_user_id,nick_name) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@',%d,'%@','%@')",
                     [[self class] tableName],
                     self.id,
                     self.uid,
                     self.userId,
                     self.lockUserId,
                     self.type,
                     self.time,
                     self.createTime,
                     self.updateTime,
                     self.delFlag,
                     self.subUserId,
                     self.nickName];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"d_open_lock_record";
}

+ (BOOL)isManagerForUserId:(NSString *)userId withUid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSAssert(uid != nil, @"uid不能为空");
    NSAssert(deviceId != nil, @"deviceId不能为空");
    //此处要先判断针对uid和deviceID判断userId针对此锁是否为管理员
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM u_family_user WHERE uid = '%@' AND user_id = '%@' AND del_flag = 0", uid, userId];
    __block BOOL isManager = YES;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            isManager = NO;
            break;
        }
        [set close];
    }
    
    return isManager;
//    NSString *sql = [NSString stringWithFormat:@"SELECT creator FROM d_device_user_bind WHERE user_id = '%@' AND uid = '%@' AND device_id = '%@' AND del_flag = 0", userId, uid, deviceId];
//    __block NSString *creator = nil;
//    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
//        creator = [rs stringForColumn:@"creator"];
//    });
    return isManager;
}

+ (NSString *)generatorQueryUpdateTimeConditionWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    BOOL isManager = [self isManagerForUserId:userId withUid:uid deviceId:deviceId];
    NSString *condition = @"";
    if (isManager) {
        condition = [NSString stringWithFormat:@"sub_user_id = '%@' AND sub_user_id = user_id", userId];
        DLog(@"管理员,条件: %@", condition);
    } else {
        condition = [NSString stringWithFormat:@"sub_user_id = '%@'", userId];
        DLog(@"子用户,条件: %@", condition);
    }
    return condition;
}

+ (NSString *)maxUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *condition = [self generatorQueryUpdateTimeConditionWithUserId:userId uid:uid deviceId:deviceId];
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(update_time) FROM %@ WHERE uid = '%@' AND %@", [[self class] tableName], uid, condition];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MAX(update_time)"];
    });
    return maxUpdateTime;
}

+ (NSString *)minUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *condition = [self generatorQueryUpdateTimeConditionWithUserId:userId uid:uid deviceId:deviceId];
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT MIN(update_time) FROM %@ "
                     "WHERE uid = '%@' AND %@",
                     [[self class] tableName], uid, condition];
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
