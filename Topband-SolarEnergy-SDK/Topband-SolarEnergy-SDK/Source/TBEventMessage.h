//
//  EventMessage.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/24.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBEventMessage : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) int readType;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) int delFalg;
@property (nonatomic, copy) NSString *deviceEventId;

@property (nonatomic, assign) int readStatus; //0：未读,1：已读
@end
