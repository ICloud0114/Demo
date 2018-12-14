//
//  TBReadTableManager.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBReadTableManager.h"
#import "TBReadTableTask.h"
#import "TBLocalAccount+TableCoding.h"
#import "TBUserNotifications.h"

NSString *const TBReadTableSuccessNotification = @"_tbReadTableSuccessNotification";
NSString *const TBReadTableNameKey = @"_tbReadTableNameKey";
NSString *const TBAllTalbeName = @"all";

@interface TBReadTableManager() <TBReadTableTaskDelegate>

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, copy, readonly) NSString *userId;

@end

@implementation TBReadTableManager

- (void)readTableWithTask:(TBReadTableTask *)task {
    [task execute];
}

- (void)readAllTables:(TBCloudRequestCompleteBlock)block {
    NSString *allTableName = TBAllTalbeName; 
    [self readTableWithTableName:allTableName uid:nil deviceId:nil userId:nil completion:block];
}

- (void)readTableWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId completion:(TBCloudRequestCompleteBlock)block {
    NSString *allTableName = TBAllTalbeName;
    NSString *tName = tableName;
    NSString *uId = uid;
    NSString *dId = deviceId;
    if ([tName isEqualToString:allTableName]) {
        uId = nil;
        dId = nil;
    }
    [self _readTableWithTableName:tName uid:uId deviceId:dId userId:userId completion:block];
}

- (void)_readTableWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId completion:(TBCloudRequestCompleteBlock)block {
    TBReadTableTask *task = [self taskWithTableName:tableName uid:uid device:deviceId];
    if (task == nil) {
        task = [TBReadTableTask instanceWithTableName:tableName uid:uid deviceId:deviceId userId:self.userId];
        if (userId) {
            task.userId = userId;
        }
        task.delegate = self;
        [task.completionBlocks addObject:block];
        [self readTableWithTask:task];
    } else {
        [task.completionBlocks addObject:block];
    }
}

- (TBReadTableTask *)taskWithTableName:(NSString *)tableName uid:(NSString *)uid device:(NSString *)deviceId {
    NSPredicate *pred = nil;
    if (tableName && uid && deviceId) {
        pred = [NSPredicate predicateWithFormat:@"self.tableName = %@ and self.uid = %@ and self.deviceId = %@",tableName,uid,deviceId];
    } else if (tableName && uid) {
        pred = [NSPredicate predicateWithFormat:@"self.tableName = %@ and self.uid = %@",tableName,uid];
    } else {
        pred = [NSPredicate predicateWithFormat:@"self.tableName = %@",tableName,uid];
    }
    NSArray *findArray = [self.tasks filteredArrayUsingPredicate:pred];
    return [findArray firstObject];
}

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static TBReadTableManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[TBReadTableManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(asyncDataNotification:) name:NOTIFICATION_ASYNC_RECEIVE_DATA object:nil];
    }
    return self;
}

#pragma mark - Notification
- (void)asyncDataNotification:(NSNotification *)notification {
    NSNumber *cmd = [notification object];
    if ([cmd intValue] != 51) {
        return;
    }
    DLog(@"收到服务器要求同步表的通知，现在开始同步------");
    NSDictionary *payload = notification.userInfo;
    NSDictionary *data = [payload objectForKey:@"data"];
    NSString *deviceId = [data objectForKey:@"deviceId"];
    NSString *uid = [data objectForKey:@"uid"];
    NSString *userId = [data objectForKey:@"userId"];
    NSString *tableName = [data objectForKey:@"tableName"];
    if (tableName != nil && tableName.length > 0) {
        DLog(@"开始同步表:<%@>", tableName);
        [self readTableWithTableName:tableName uid:uid deviceId:deviceId userId:userId completion:^(TBResponse * _Nonnull response) {
            DLog(@"表:<%@>数据同步%@", tableName, (response.status == TBStatusSuccess) ? @"成功": @"失败");
            if (response.status == TBStatusSuccess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:TBUserLocalDataUpdateNotification object:nil userInfo:nil];
            }
        }];
    }
}

#pragma mark - TBReadTableTaskDelegate
- (void)didReadTableSuccess:(TBReadTableTask *)task {
    for (TBCloudRequestCompleteBlock block in task.completionBlocks) {
        dispatch_async_main(^{
            block([[TBResponse alloc] initWithStatus:TBStatusSuccess result:nil]);
        });
    }
    dispatch_async_main(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TBReadTableSuccessNotification
                                                            object:nil
                                                          userInfo:@{
                                                                     TBReadTableNameKey: task.tableName
                                                                     }];
    });
    [self.tasks removeObject:task];
}

- (void)readTableTask:(TBReadTableTask *)task didReadTableFailed:(TBResponse *)response {
    for (TBCloudRequestCompleteBlock block in task.completionBlocks) {
        dispatch_async_main(^{
            block([[TBResponse alloc] initWithStatus:response.status result:nil]);
        });
    }
    [self.tasks removeObject:task];
}

#pragma mark - getter setter
- (NSString *)userId {
    TBLocalAccount *la = [TBLocalAccount lastAccountInfo];
    NSAssert(la.userId, @"读表服务异常，未登录就开始了读表任务");
    return la.userId;
}

- (NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = @[].mutableCopy;
    }
    return _tasks;
}
@end
