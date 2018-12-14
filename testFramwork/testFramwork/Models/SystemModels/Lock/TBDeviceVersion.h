//
//  TBDeviceVersion.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/12/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
//id    varchar(36) NOT NULL
//device_id    varchar(36) NOT NULL    设备主键
//product_id    varchar(36) NULL    产品id
//type    int(11) NULL    模块类型,门锁，1-电源模块，2-主模块，3-NB模块
//version    varchar(36) NULL    版本
//create_time    timestamp NOT NULL
//update_time    timestamp NOT NULL
//del_flag    int(11) NULL
@interface TBDeviceVersion : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *productId;

@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@end
