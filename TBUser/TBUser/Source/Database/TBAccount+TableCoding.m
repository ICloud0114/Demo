//
//  TBAccount+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBAccount+TableCoding.h"
#import <MJExtension/MJExtension.h>

@implementation TBAccount (TableCoding)

+ (NSString *)tableName {
    return @"account";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS "
                     "%@ (uid TEXT,"
                     "password TEXT,"
                     "phone TEXT, "
                     "email TEXT,"
                     "nickName TEXT,"
                     "headImage TEXT,"
                     "address TEXT,"
                     "sex INTEGER,"
                     "birthday TEXT,"
                     "userType INTEGER,"
                     //    "createTime text,"
                     //    "updateTime text,"
                     //    "delFlag integer,"
                     "UNIQUE(uid) ON CONFLICT REPLACE)", [self tableName]];
   ;
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (uid, password, phone, email, nickName, headImage, address, sex, birthday,userType) VALUES('%@','%@','%@','%@','%@','%@','%@',%d,'%@',%d)", [[self class] tableName], self.uid, self.password, self.phone, self.email, self.nickName, self.headImage, self.address, self.sex, self.birthday,self.userType];
    return sql;
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (instancetype)instanceWithUserId:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM account WHERE uid = '%@'", userId];
    TBAccount *account = nil;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        if ([set next]) {
            NSDictionary *dic = set.resultDictionary;
            account = [TBAccount mj_objectWithKeyValues:dic];
        }
        [set close];
    }
    return account;
}

- (void)updateNickname:(NSString *)nickName {
    if ([self.nickName isEqualToString:nickName]) { return; }
    self.nickName = nickName;
    [self insertObject];
}

- (void)updateHeadPortrait:(NSString *)url {
    if ([self.headImage isEqualToString:url]) { return; }
    self.headImage = url;
    [self insertObject];
}

- (void)update {
    [self insertObject];
}

- (BOOL)updatePassword:(NSString *)password {
    self.password = password;
    return [self insertObject];
}
@end
