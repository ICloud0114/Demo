//
//  TBLockUser+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/8.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBLockUser+TableCoding.h"

@implementation TBLockUser (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "lock_user_id INTEGER,"
                     "user_type INTEGER,"
                     "key_type INTEGER,"
                     "password TEXT,"
                     "del_flag INTEGER,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "start_time TEXT,"
                     "end_time TEXT,"
                     "password_id TEXT,"
                     "user_id TEXT,"
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
                     @"INSERT INTO %@ (id,uid,lock_user_id,user_type,key_type,password,del_flag,create_time,update_time,start_time,end_time,password_id,user_id,sub_user_id,nick_name) VALUES ('%@','%@',%d,%d,%d,'%@',%d,'%@','%@','%@','%@','%@','%@','%@','%@')",
                     [[self class] tableName],
                     self.id,
                     self.uid,
                     self.lockUserId,
                     self.userType,
                     self.keyType,
                     self.password,
                     self.delFlag,
                     self.createTime,
                     self.updateTime,
                     self.startTime,
                     self.endTime,
                     self.passwordId,
                     self.userId,
                     self.subUserId,
                     self.nickName];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    
    if (!self.passwordId) {
        NSString *str = [NSString stringWithFormat:@"%d", self.lockUserId];
        self.passwordId = md5WithStr(str);
    }
    self.nickName = [self.nickName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    
    NSString *sql = [self prepareSql];
    
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"d_lock_user";
}

+ (BOOL)updateNickName:(NSString *)nickName withId:(NSString *)id {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET nick_name = '%@' WHERE id = '%@'", [self tableName], nickName, id];
    return executeUpdate(sql);
}

@end
