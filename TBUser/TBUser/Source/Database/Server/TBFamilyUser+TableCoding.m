//
//  TBFamilyUser+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBFamilyUser+TableCoding.h"

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

@end
