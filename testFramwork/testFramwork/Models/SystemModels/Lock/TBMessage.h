//
//  TBMessage.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/3.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBMessage : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;

@end
