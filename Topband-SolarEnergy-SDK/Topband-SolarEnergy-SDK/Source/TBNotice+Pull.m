//
//  TBNotice+Pull.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBNotice+Pull.h"
#import <TBDataBase/TBDataBaseManager.h>
#import "TBNotice+TableCoding.h"

@implementation TBNotice (Pull)

+ (NSString *)maxUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MAX(update_time)"];
    });
    return maxUpdateTime;
}

+ (NSString *)minUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId {
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MIN(update_time)"];
    });
    return maxUpdateTime;
}

@end
