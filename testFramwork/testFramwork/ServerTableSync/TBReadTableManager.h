//
//  TBReadTableManager.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//
//实时同步服务器表数据

#import <Foundation/Foundation.h>

extern NSString *const TBReadTableSuccessNotification;
extern NSString *const TBReadTableNameKey;
extern NSString *const TBAllTalbeName;

@interface TBReadTableManager : NSObject

+ (instancetype)share;

- (void)readAllTables:(TBCloudRequestCompleteBlock)block;

- (void)readLockUserTableWithUid:(NSString *)uid deviceId:(NSString *)deviceId completion:(TBCloudRequestCompleteBlock)block;

- (void)readDeviceTable:(TBCloudRequestCompleteBlock)block;

- (void)readTableWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId completion:(TBCloudRequestCompleteBlock)block;

//启动服务
- (void)launchService;
@end

