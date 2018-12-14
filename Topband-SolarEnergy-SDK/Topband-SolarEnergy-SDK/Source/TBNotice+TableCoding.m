//
//  Notice+TableCoding.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/24.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBNotice+TableCoding.h"

@implementation TBNotice (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "title TEXT,"
                     "content TEXT,"
                     "release_time TEXT,"
                     "company_id TEXT,"
                     "product_id TEXT,"
                     "del_flag INTEGER,"
                     "create_by TEXT,"
                     "update_by TEXT,"
                     "create_time TEXT,"
                     "update_time TEXT,"
                     "read_status INTEGER DEFAULT 0," //额外属性,记录当前消息是否已读
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
                         "title,"
                         "content,"
                         "release_time,"
                         "company_id,"
                         "product_id,"
                         "del_flag,"
                         "create_by,"
                         "update_by,"
                         "create_time,"
                         "update_time,"
                         "read_status"
                     ") "
                     "VALUES "
                     "("
                         "'%@'," //id
                         "'%@'," //title
                         "'%@'," //content
                         "'%@'," //release_time
                         "'%@',"  //company_id
                         "'%@',"    //product_id
                         "%d," //del_flag
                         "'%@'," //create_by
                         "'%@'," //update_by
                         "'%@'," //create_time
                         "'%@'," //update_time
                         "%d" //read_status
                     ")",
                     [[self class] tableName],
                     self.id,
                     self.title,
                     self.content,
                     self.releaseTime,
                     self.companyId,
                     self.productId,
                     self.delFlag,
                     self.createBy,
                     self.updateBy,
                     self.createTime,
                     self.updateTime,
                     self.readStatus];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    //插入之前，先读取一下当前消息的read_status
    NSString *readStatusSql = [NSString stringWithFormat:
                               @"SELECT read_status AS readStatus FROM %@ WHERE id = '%@'", [[self class] tableName], self.id];
    FMResultSet *set = [db executeQuery:readStatusSql];
    int readStatus = 0;
    if ([set next]) {
        readStatus = [set intForColumn:@"readStatus"];
    }
    [set close];
    self.readStatus = readStatus;
    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"t_notice";
}

+ (NSString *)maxUpdateTime {
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MAX(update_time)"];
    });
    return maxUpdateTime;
}

+ (NSString *)minUpdateTime {
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MIN(update_time)"];
    });
    return maxUpdateTime;
}

@end
