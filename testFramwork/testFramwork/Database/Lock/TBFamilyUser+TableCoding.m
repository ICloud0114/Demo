//
//  TBFamilyUser+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBFamilyUser+TableCoding.h"

//id    varchar(32)
//family_id    varchar(32)    家庭Id
//user_id    varchar(32)    用户Id
//user_type    int(11)    0:管理员 1: 非管理员
//nick_name_in_family    varchar(100)
//create_time    datetime
//update_time    datetime
//uid     varchar(36)
//del_flag    int(11)

@implementation TBFamilyUser (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "family_id TEXT,"
                     "user_id TEXT,"
                     "user_type INTEGER,"
                     "nick_name_in_family TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "uid TEXT,"
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
                     @"INSERT INTO %@ (id, family_id, user_id, user_type, nick_name_in_family, create_time, update_time, uid, del_flag) VALUES ('%@','%@','%@', %d, '%@', '%@', '%@', '%@', %d)",
                     [[self class] tableName],
                     self.id,
                     self.familyId,
                     self.userId,
                     self.userType,
                     self.nickNameInFamily,
                     self.createTime,
                     self.updateTime,
                     self.uid,
                     self.delFlag];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"u_family_user";
}

+ (BOOL)updateNickName:(NSString *)nickName withUid:(NSString *)uid userId:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET nick_name_in_family = '%@' WHERE uid = '%@' AND user_id = '%@'", [self tableName], nickName, uid, userId];
    return executeUpdate(sql);
}

+ (BOOL)removeLocalShareUserWithUserId:(NSString *)userId uid:(NSString *)uid {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET del_flag = 1 WHERE user_id = '%@' AND uid = '%@'", [TBFamilyUser tableName], userId, uid];
    return executeUpdate(sql);
}


@end
