//
//  TBLocalAccount+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBLocalAccount+TableCoding.h"
#import <MJExtension/MJExtension.h>

@implementation TBLocalAccount (TableCoding)

+ (NSString *)tableName {
    return @"localAccount";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@("
                     "userId TEXT PRIMARY KEY ON CONFLICT REPLACE,"
                     "loginTime INTEGER,"
                     "account TEXT UNIQUE ON CONFLICT REPLACE,"
                     "password TEXT"
                     ")", [self tableName]];
    ;
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *getMaxLoginTimeSql = @"SELECT max(loginTime) FROM localAccount";
    __block int maxLoginTime = 0;
    queryDatabase(getMaxLoginTimeSql, ^(FMResultSet * _Nonnull rs) {
        maxLoginTime = [rs intForColumn:@"max(loginTime)"];
    });
    if (self.loginTime <= maxLoginTime) {
        self.loginTime = maxLoginTime + 1;
    }
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO localAccount (userId,loginTime,account,password) "
                      "VALUES('%@', %d,'%@','%@')",self.userId,self.loginTime,self.account,self.password];
    return sql;
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (instancetype)lastAccountInfo {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM localAccount WHERE loginTime = (SELECT max(loginTime) FROM localAccount)"];
    TBLocalAccount *obj = nil;
    @autoreleasepool {
        FMResultSet *resultSet = executeQuery(sql);
        if ([resultSet next]) {
            obj = [TBLocalAccount new];
            NSDictionary *dic = resultSet.resultDictionary;
            obj = [TBLocalAccount mj_objectWithKeyValues:dic];
        }
        [resultSet close];
    }
    return obj;
}

- (BOOL)deleteLocalAccount {
    NSString *sql = [NSString stringWithFormat:@"DELETE from %@ WHERE userId = '%@'", [[self class] tableName], self.userId];
    return executeUpdate(sql);
}

- (BOOL)updateAccount:(NSString *)account {
    self.account = account;
    return [self insertObject];
}

- (BOOL)updatePassword:(NSString *)password {
    self.password = password;
    return [self insertObject];
}

@end
