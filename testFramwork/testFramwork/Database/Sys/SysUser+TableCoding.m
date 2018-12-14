//
//  SysUser+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/1/22.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "SysUser+TableCoding.h"

@implementation SysUser (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "username TEXT,"
                     "display_name TEXT,"
                     "password TEXT,"
                     "salt TEXT,"
                     "user_type INTEGER,"
                     "telephone TEXT,"
                     "telephone2 TEXT,"
                     "email TEXT,"
                     "company_id TEXT,"
                     "status INTEGER,"
                     "address TEXT,"
                     "create_by TEXT,"
                     "update_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "UNIQUE(id) ON CONFLICT REPLACE)", [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ "
                         "("
                         "id,"
                         "username,"
                         "display_name,"
                         "password,"
                         "salt,"
                         "user_type,"
                         "telephone,"
                         "telephone2,"
                         "email,"
                         "company_id,"
                         "status,"
                         "address,"
                         "create_by,"
                         "update_by,"
                         "create_time,"
                         "update_time"
                     ") "
                     "VALUES "
                     "("
                         "'%@'," //id
                         "'%@'," //username
                         "'%@'," //display_name
                         "'%@'," //password
                         "'%@'," //salt
                         "%d," //user_type
                         "'%@'," //telephone
                         "'%@'," //telephone2
                         "'%@'," //email
                         "'%@'," //company_id
                         "%d," //status
                         "'%@'," //address
                         "'%@'," //create_by
                         "'%@'," //update_by
                         "'%@'," //create_time
                         "'%@'" //update_time
                     ")",[[self class] tableName],
                     self.id,
                     self.username,
                     self.displayName,
                     self.password,
                     self.salt,
                     self.userType,
                     self.telephone,
                     self.telephone2,
                     self.email,
                     self.companyId,
                     self.status,
                     self.address,
                     self.createBy,
                     self.updateBy,
                     self.createTime,
                     self.updateTime];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"sys_user";
}

@end
