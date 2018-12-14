//
//  Notice.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/24.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBNotice : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *releaseTime;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) int delFlag;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, assign) int readStatus; //0：未读,1：已读

@end
