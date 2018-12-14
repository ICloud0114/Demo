//
//  TBDatabaseVersion+TableCoding.m
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/3/14.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBDatabaseVersion+TableCoding.h"

@implementation TBDatabaseVersion (TableCoding)

+ (TBDatabaseVersion *)oldVersion {
    if (!tableExists([self tableName])) {
        [self createTable];
        
        TBDatabaseVersion *dbVersion = [TBDatabaseVersion new];
        dbVersion.version = DATABASE_VERSION;
        [dbVersion insertObject];
        return dbVersion;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT version FROM %@ WHERE versionId = 1", [self tableName]];
    __block NSString *version = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        version = [rs stringForColumn:@"version"];
    });
    TBDatabaseVersion *dbVersion = [TBDatabaseVersion new];
    if (version) {
        dbVersion.version = version;
    } else {
        dbVersion.version = DATABASE_VERSION;
    }
    return dbVersion;
}

+ (BOOL)saveCurrentDatabaseVersion {
    TBDatabaseVersion *dbVersion = [TBDatabaseVersion new];
    dbVersion.version = DATABASE_VERSION;
    return [dbVersion insertObject];
}

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS "
                     "%@ (versionId INTEGER UNIQUE ON CONFLICT REPLACE DEFAULT 1,"
                     "version TEXT)", [self tableName]];
    return executeUpdate(sql);
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (versionId, version) VALUES (1, '%@')", [[self class] tableName], self.version];
    return sql;
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    return [db executeUpdate:[self prepareSql]];
}

+ (NSString *)tableName {
    return @"tbDatabase_version";
}

@end
