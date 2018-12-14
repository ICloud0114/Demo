//
//  TBMessagePushSetting.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//
//消息推送设置表

#import <Foundation/Foundation.h>

@interface TBMessagePushSetting : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, assign) int pushFlag;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) int weak;

@end
