//
//  TBMessagePull.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBMessagePull.h"
#import <MJExtension/MJExtension.h>
#import "TBQueryDataUpOrDownCmd.h"


@interface TBMessagePull()

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy, readonly) NSString *tableName;

@property (nonatomic) Class<TBTableCoding, TBMessagePullObject> messageObjectClass;
@end

@implementation TBMessagePull

- (instancetype)initWithUid:(NSString *)uid
                   devcieId:(NSString *)deviceId
                     userId:(nonnull NSString *)userId
     messagePullObjectClass:(nonnull Class<TBTableCoding,TBMessagePullObject>)objectClass {
    self = [super init];
    if (self) {
        _uid = uid;
        _deviceId = deviceId;
        _userId = userId;
        _messageObjectClass = objectClass;//[self tableNameWithMessageType:type];
    }
    return self;
}

- (void)pullMessageWithCompletion:(TBCloudRequestCompleteBlock)block {
    TBQueryDataUpOrDownCmd *cmd = [self upOrDownCmd];
    cmd.type = 0;
    cmd.updateTime = secondWithDataValue([self updateTimeWithType:0]);
    [self startPullWithCmd:cmd completion:block];
}

- (void)dropDownMessage:(TBCloudRequestCompleteBlock)block {
    TBQueryDataUpOrDownCmd *cmd = [self upOrDownCmd];
    cmd.type = 1;
    cmd.updateTime = secondWithDataValue([self updateTimeWithType:1]);
    [self startPullWithCmd:cmd completion:block];
}

- (void)saveTable:(NSString *)tableN data:(NSArray *)arr complete:(void (^)(void))complete {
    Class<TBTableCoding> tableClass = [[TBDatabaseManager shareInstance].tableModelMaps objectForKey:tableN];
    NSMutableArray<id<TBTableCoding>> *tableModels = @[].mutableCopy;
    for (NSDictionary *dic in arr) {
//        [self updateReadTableTime:dic[@"updateTime"]];
        id<TBTableCoding> obj = [tableClass performSelector:@selector(mj_objectWithKeyValues:) withObject:dic];
        [tableModels addObject:obj];
    }
//    [self saveUpdateTime];
    inTransaction(^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        [tableModels enumerateObjectsUsingBlock:^(id<TBTableCoding>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL result = [obj insertObjectWithDb:db];
            if (!result) {
                *rollback = YES;
            }
        }];
        //保存完后回调
        dispatch_async_main(complete);
    });
}

- (void)saveTableData:(NSDictionary *)data complete:(void (^)(void))complete {
    NSArray *tableNameList = [data objectForKey:@"tableNameList"];
    if (!(tableNameList.count > 0)) {
        DLog(@"读表%@,返回了空的数据😢", self.tableName);
        complete();
        return;
    }
    __weak typeof(self) weakSelf = self;
    inSerialQueue(^{
        NSMutableArray *ary = @[].mutableCopy;
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        for (NSString *tn in tableNameList) {
            @autoreleasepool {
                [weakSelf saveTable:tn data:data[tn] complete:^{
                    [ary addObject:@YES];
                    if (ary.count == tableNameList.count) {
                        dispatch_semaphore_signal(semaphore);
                    }
                }];
            }
        }
        dispatch_queue_t queue = dispatch_queue_create("com.datastore.com", NULL);
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            DLog(@"读表%@的数据存储成功", self.tableName);
            dispatch_async_main(complete);
        });
    });
}

- (void)startPullWithCmd:(TBQueryDataUpOrDownCmd *)cmd completion:(TBCloudRequestCompleteBlock)block {
    __weak typeof(self) weakSelf = self;
    sendCmd(cmd, ^(TBResponse *response) {
        if (response.status == TBStatusSuccess) {
            NSDictionary *data = [response.result objectForKey:@"data"];
            [weakSelf saveTableData:data complete:^{
                block([[TBResponse alloc] initWithStatus:response.status result:nil]);
            }];
        } else {
            block(response);
        }
    });
}

- (TBQueryDataUpOrDownCmd *)upOrDownCmd {
    TBQueryDataUpOrDownCmd *cmd = [TBQueryDataUpOrDownCmd cmdInstance];
    cmd.tableName = self.tableName;
//    cmd.type = 1;
//    cmd.updateTime = secondWithDataValue(UserDefaultsValue([self updateTimeSecKey]));;
    cmd.deviceId = self.deviceId;
    cmd.uid = self.uid;
    return cmd;
}

#pragma mark - getter setter

/**
 0:上拉,获取比这个时间小的数据.
 1:下拉,获取比这个时间大的数据.
 */
- (NSString *)updateTimeWithType:(int)type {
    if (type == 0) {
        return [self.messageObjectClass minUpdateTimeWithUserId:self.userId uid:self.uid deviceId: self.deviceId];
    } else {
        return [self.messageObjectClass maxUpdateTimeWithUserId:self.userId uid:self.uid deviceId: self.deviceId];
    }
}

- (NSString *)tableName {
    return [self.messageObjectClass tableName];
}

//- (NSString *)tableNameWithMessageType:(TBMessagePullType)type {
//#if defined(SMART_LOCK)
//    switch (type) {
//        case TBMessagePullOpenLockRecord:
//            return @"d_open_lock_record";            
//        case TBMessagePullMessage:
//            return @"t_message";
//    }
//#elif defined(SOLAR_ENERGY)
//    switch (type) {
//        case TBMessagePullNotice:
//            return @"t_notice";
//        case TBMessageEventMessage:
//            return @"d_event_message";
//    }
//#endif
//}



@end
