//
//  TBGateway+TableCoding.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBGateway+TableCoding.h"
#import "MJExtension.h"

@implementation TBGateway (TableCoding)

//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    return [propertyName mj_underlineFromCamel];
//}

+ (NSString *)tableName {
    return @"d_gateway";
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "upload_user TEXT,"
                     "activated_state INTEGER,"
                     "ip TEXT,"
                     "country TEXT,"
                     "province TEXT,"
                     "city TEXT,"
                     "online INTEGER,"
                     "work_status INTEGER,"
                     "delFlag INTEGER,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "timezone INTEGER,"
                     "UNIQUE(id,uid) ON CONFLICT REPLACE)", [self tableName]];
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (id,uid,upload_user,activated_state,ip,country,province,city,online,work_status,delFlag,create_time,update_time,timezone) VALUES ('%@','%@','%@',%d,'%@','%@','%@','%@',%d,%d,%d,'%@','%@',%d)",
                     [[self class] tableName],
                     self.id,
                     self.uid,
                     self.uploadUser,
                     self.activatedState,
                     self.ip,
                     self.country,
                     self.province,
                     self.city,
                     self.online,
                     self.workStatus,
                     self.delFlag,
                     self.createTime,
                     self.updateTime,
                     self.timezone];
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
