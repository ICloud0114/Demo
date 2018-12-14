//
//  TBReadTableManager.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBReadTableManager.h"
#import "SingletionClass.h"
#import "TBReadTableTask.h"
#import "TBLocalAccount+TableCoding.h"

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

- (void)readLockUserTableWithUid:(NSString *)uid deviceId:(NSString *)deviceId completion:(TBCloudRequestCompleteBlock)block {
    [self readTableWithTableName:@"d_lock_user" uid:uid deviceId:deviceId userId:nil completion:block];
}

- (void)readDeviceTable:(TBCloudRequestCompleteBlock)block {
    [self readTableWithTableName:@"d_device" uid:nil deviceId:nil userId:self.userId completion:block];
}

- (void)readAllTables:(TBCloudRequestCompleteBlock)block {
    NSString *allTableName = TBAllTalbeName;
//#if defined(SMART_LOCK)
//    allTableName = @"all";
//#elif defined(SOLAR_ENERGY)
//    allTableName = @"allSun";
//#endif
    [self readTableWithTableName:allTableName uid:nil deviceId:nil userId:nil completion:block];
}

- (void)readTableWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId completion:(TBCloudRequestCompleteBlock)block {
    NSString *allTableName = TBAllTalbeName;
//#if defined(SMART_LOCK)
//    allTableName = @"all";
//#elif defined(SOLAR_ENERGY)
//    allTableName = @"allSun";
//#endif
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
        if (task.userId == nil){
            [task.completionBlocks addObject:block];
        }else{
            task.delegate = self;
            [task.completionBlocks addObject:block];
            [self readTableWithTask:task];
        }
        
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
    Singleton();
}

- (void)launchService {
    
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
//    NSAssert(la.userId, @"读表服务异常，未登录就开始了读表任务");
    return la.userId;
}

- (NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = @[].mutableCopy;
    }
    return _tasks;
}
@end
