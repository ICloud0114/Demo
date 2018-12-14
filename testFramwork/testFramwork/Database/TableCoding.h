//
//  TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBDatabaseManager.h"

@protocol TableCoding <NSObject>

@required
+ (NSString *)tableName; //表名
+ (BOOL)createTable; //创建表的sql语句
- (BOOL)insertObject;
- (BOOL)insertObjectWithDb:(FMDatabase *)db;

@optional
+ (NSString *)maxUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId; //获取当前表的最大更新时间
+ (NSString *)minUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId;; //获取当前表的最小更新时间
+ (BOOL)cleanAllData;//清空本地数据
@end
