//
//  TBDeviceUpgradePackage.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/12/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
//id    varchar(36) NOT NULL
//upgrade_package_id    varchar(36) NULL
//product_id    varchar(36) NULL    产品ID
//device_id    varchar(36) NULL    设备ID.(备用字段,电子锁没有用到)
//name    varchar(255) NULL    版本名称 (根据这个名称可以判断) version
//version_no    bigint(32) NULL    版本编号(name对应的Long类型,尽量不用这个判断)
//package_type    int(3) NULL    1:电源模块, 2 : 主板模块 3: NB模块
//original_file_name    varchar(255) NULL    原文件名称
//file_size    double NULL
//file_md5    varchar(32) NULL
//file_path    varchar(500) NULL
//upgrade_time    timestamp NULL
//create_by    varchar(36) NULL    创建人
//desc    varchar(600) NULL    描述
//create_time    timestamp NULL
//update_time    timestamp NULL
//del_flag    int(2) NULL
@interface TBDeviceUpgradePackage : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *upgradePackageId;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int version_no;
@property (nonatomic, assign) int packageType;
@property (nonatomic, copy) NSString *originalFileName;
@property (nonatomic, assign) double fileSize;
@property (nonatomic, copy) NSString *fileMd5;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *upgradeTime;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@end
