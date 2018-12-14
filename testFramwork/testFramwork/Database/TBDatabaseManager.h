//
//  TBDatabaseManager.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^FMBlock)(FMResultSet *rs);
//事务回调
typedef void(^FMTBlock)(FMDatabase *db, BOOL *rollback);

@protocol TableCoding;
@interface TBDatabaseManager : NSObject

+ (instancetype)shareInstance;

- (void)initDatabase;

@property (nonatomic, strong, readonly) FMDatabase *db;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, Class<TableCoding>> *tableModelMaps;

//主线程
- (BOOL)executeUpdate:(NSString *)sql, ...;
//主线程
- (FMResultSet *)executeQuery:(NSString *)sql, ...;

- (void)inSerialQueue:(void (^)(void))block;

- (void)inTransaction:(FMTBlock)block;

- (void)inDatabase:(void (^)(FMDatabase *db))block;

- (BOOL)isExistsForTable:(NSString *)tableName;

//重置服务表
- (void)resetServerTable;

@end

static inline BOOL tableExists(NSString *tableName) {
    return [[TBDatabaseManager shareInstance] isExistsForTable:tableName];
}

static inline BOOL executeUpdate(NSString * _Nonnull sql, ...) {
    return [[TBDatabaseManager shareInstance] executeUpdate:sql];
}

static inline FMResultSet *executeQuery(NSString *sql, ...) {
    return [[TBDatabaseManager shareInstance] executeQuery:sql];
}

void queryDatabase(NSString *sql, FMBlock block);

static inline void inSerialQueue(void (^block)(void)) {
    [[TBDatabaseManager shareInstance] inSerialQueue:block];
}

static inline void inTransaction(FMTBlock block) {
    [[TBDatabaseManager shareInstance] inTransaction:block];
}
NS_ASSUME_NONNULL_END


