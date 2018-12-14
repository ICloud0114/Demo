//
//  TBReadTableTask.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <tSmartSDK/tSmartSDK.h>

@class TBReadTableTask;
@protocol TBReadTableTaskDelegate <NSObject>

//当前读表任务所有数据都读取完成
- (void)didReadTableSuccess:(TBReadTableTask *)task;

- (void)readTableTask:(TBReadTableTask *)task didReadTableFailed:(TBResponse *)response;

@end

@interface TBReadTableTask : NSObject

+ (instancetype)instanceWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId;

//表名
@property (nonatomic, copy) NSString *tableName;
//设备mac
@property (nonatomic, copy) NSString *uid;
//device id
@property (nonatomic, copy) NSString *deviceId;
//user id
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, weak) id<TBReadTableTaskDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<TBCloudRequestCompleteBlock> *completionBlocks;

//更新读表时间
- (void)updateReadTableTime:(NSString *)updateTime;
//保存读表时间
- (void)saveUpdateTime;
- (void)execute;
@end

