//
//  TBDatabaseManager.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDatabaseManager.h"
#import "SingletionClass.h"
#import "Tables.h"

@interface TBDatabaseManager() {
    dispatch_queue_t _databaseQueue;
}

@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

@implementation TBDatabaseManager
@synthesize tableModelMaps = _tableModelMaps;

- (BOOL)executeUpdate:(NSString *)sql, ... {
    return [self.db executeUpdate:sql];
}

- (FMResultSet *)executeQuery:(NSString *)sql, ... {
    return [self.db executeQuery:sql];
}

- (void)inSerialQueue:(void (^)(void))block {
    dispatch_async(_databaseQueue, block);
}

- (void)inTransaction:(FMTBlock)block {
    [self.dbQueue inTransaction:block];
}

- (void)inDatabase:(void (^)(FMDatabase * _Nonnull))block {
    [self.dbQueue inDatabase:block];
}

- (BOOL)isExistsForTable:(NSString *)tableName {
    return [self.db tableExists:tableName];
}

- (void)createTable {
    NSMutableArray<Class<TableCoding>> *tables = @[].mutableCopy;
    [tables addObjectsFromArray:[Tables serverTables]];
    [tables addObjectsFromArray:[Tables localTables]];
    for (Class<TableCoding> tableCla in tables) {
        [tableCla createTable];
    }
}

- (void)dropServerTable {
    DLog(@"删除服务表");
    NSArray *tables = [Tables serverTables];
    
    for (Class<TableCoding> aClass in tables) {
        NSString *tableName = [aClass tableName];
        NSString *dropTableSql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",tableName];
        [self executeUpdate:dropTableSql];
    }
}

- (void)resetServerTable{
    DLog(@"重置服务表");
    [self dropServerTable];
    [self createTable];
}

- (void)initDatabase {
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:DATABASE_NAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDbExist = [fileManager fileExistsAtPath:dbPath];
    if (!isDbExist) {
        BOOL result = [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
        DLog(@"数据库创建%@", result ? @"成功": @"失败");
    }
    
    self.dbPath = dbPath;
    //打开数据库
    if ([self.db open]) {
        [self dbQueue];
        
        if (!isDbExist) {
            [self createTable];
            //保存当前数据库版本
            [TBDatabaseVersion saveCurrentDatabaseVersion];
        } else {
            TBDatabaseVersion *oldDbVersion = [TBDatabaseVersion oldVersion];
            if (![oldDbVersion.version isEqualToString:DATABASE_VERSION]) { //版本发生变化
                //1️⃣清除读表时间
//                cleanLastUpdateTime(@"UpdateTime");
                //2️⃣删除服务器表
                [self dropServerTable];
                //3️⃣重新创建表
                [self createTable];
                //4️⃣更新数据库版本
                oldDbVersion.version = DATABASE_VERSION;
                [oldDbVersion insertObject];
            } else {
                DLog(@"数据库版本号未发生改变");
                [self createTable];
            }
        }
    }
}

+ (instancetype)shareInstance {
    Singleton();
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _databaseQueue = dispatch_queue_create([[NSString stringWithFormat:@"database.%@", self] UTF8String], NULL);
    }
    return self;
}

- (NSDictionary<NSString *, Class<TableCoding>> *)tableModelMaps {
    if (!_tableModelMaps) {
        _tableModelMaps = @{}.mutableCopy;
        NSArray<Class<TableCoding>> *serverTables = [Tables serverTables];
        for (Class<TableCoding> tableModel in serverTables) {
            [_tableModelMaps setValue:tableModel forKey:[tableModel tableName]];
        }
    }
    return _tableModelMaps;
}

- (FMDatabase *)db {
    if (!_db) {
        _db = [[FMDatabase alloc] initWithPath:self.dbPath];
    }
    return _db;
}

- (FMDatabaseQueue *)dbQueue {
    if (!_dbQueue) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:self.dbPath];
    }
    return _dbQueue;
}

@end

void queryDatabase(NSString *sql, FMBlock block) {
    @autoreleasepool {
        FMResultSet *rs = executeQuery(sql);
        while ([rs next]) {
            block(rs);
        }
        [rs close];
    }
}

