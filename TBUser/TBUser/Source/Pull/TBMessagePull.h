//
//  TBMessagePull.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//

//用于消息拉取
#import <Foundation/Foundation.h>
#import "TBMessagePullObject.h"
#import <TBDataBase/TBTableCoding.h>
#import <tSmartSDK/tSmartSDK.h>

//typedef NS_ENUM(NSInteger, TBMessagePullType) {
//#if defined(SMART_LOCK)
//    TBMessagePullOpenLockRecord, //拉取开门记录
//    TBMessagePullMessage //拉取设备消息
//#elif defined(SOLAR_ENERGY)
//    TBMessagePullNotice, //拉取公告
//    TBMessageEventMessage //拉取时间消息
//#endif
//};

NS_ASSUME_NONNULL_BEGIN
@interface TBMessagePull : NSObject

- (instancetype)initWithUid:(NSString * _Nullable)uid
                   devcieId:(NSString * _Nullable)deviceId
                     userId:(NSString *)userId
     messagePullObjectClass:(Class<TBTableCoding, TBMessagePullObject>)objectClass;
//上拉
- (void)pullMessageWithCompletion:(TBCloudRequestCompleteBlock)block;;

//下拉
- (void)dropDownMessage:(TBCloudRequestCompleteBlock)block;

@end
NS_ASSUME_NONNULL_END
