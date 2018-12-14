//
//  TBNotice+Extension.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBNotice+Extension.h"
#import <TBDataBase/TBDatabaseManager.h>
#import <MJExtension/MJExtension.h>
#import "TBNotice+TableCoding.h"

@implementation TBNotice (Extension)
static int pSize = 15;
+ (void)setPageSize:(int)pageSize {
    pSize = pageSize;
}

+ (int)pageSize {
    return pSize;
}

- (BOOL)readMsg {
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET read_status = 1 WHERE id = '%@'", [TBNotice tableName], self.id];
    if (executeUpdate(sql)) {
        self.readStatus = 1;
    }
    return NO;
}

+ (NSArray<TBNotice *> *)readNoticesWithPageIndex:(int)pageIndex {
    NSAssert([NSThread currentThread].isMainThread, @"not main thread call");
    int pageSize = self.pageSize;
    NSString *sql = [NSString stringWithFormat:
                     @"SELECT "
                     "id,"
                     "title,"
                     "content,"
                     "release_time AS releaseTime,"
                     "company_id AS companyId,"
                     "product_id AS productId,"
                     "del_flag AS delFlag,"
                     "create_by AS createBy,"
                     "update_by AS updateBy,"
                     "create_time AS createTime,"
                     "update_time AS updateTime,"
                     "read_status AS readStatus "
                     "FROM %@ WHERE del_flag = 0 ORDER BY release_time DESC LIMIT %d OFFSET %d", [TBNotice tableName], pageSize, pageSize * pageIndex];
    NSMutableArray *notices = @[].mutableCopy;
    @autoreleasepool {
        FMResultSet *set = executeQuery(sql);
        while ([set next]) {
            NSDictionary *dic = [set resultDictionary];
            [notices addObject:[TBNotice mj_objectWithKeyValues:dic]];
        }
        [set close];
    }
    return notices;
}

@end
