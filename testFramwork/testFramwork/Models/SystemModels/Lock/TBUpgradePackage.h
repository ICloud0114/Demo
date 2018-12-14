//
//  TBDeviceUpgradePackage.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUpgradePackage : NSObject
//id    varchar(32)    主键
//name    varchar(20)    版本名称
//version_no    int(3)    版本编号
//product_id    varchar(32)    产品ID
//device_id    varchar(32)    设备ID.
//package_type    int(2)    升级包类型. 1: Android APP; 2: MCU; 3: Android 系统.4: 太阳能采集器. 5: 电子锁NB设备主版本'
//original_file_name    varchar(255)    原文件名.
//file_size    double    文件大小, 单位: KB.
//file_md5    varchar(32)    文件MD5值
//file_path    varchar(500)    升级包保存的地址
//upgrade_time    datetime    升级时间.
//remarks    varchar(600)    版本描述
//create_by    varchar(32)    创建人
//create_time    datetime    创建时间

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int version_no;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) int packageType;
@property (nonatomic, copy) NSString *originalFileName;
@property (nonatomic, assign) double fileSize;
@property (nonatomic, copy) NSString *fileMd5;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *upgradeTime;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@end
