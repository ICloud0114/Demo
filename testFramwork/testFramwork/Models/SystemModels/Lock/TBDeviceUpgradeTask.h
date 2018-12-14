//
//  TBDeviceUpgradeTask.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
//id    varchar(36) NOT NULL
//upgrade_package_id    varchar(36) NOT NULL    t_upgrade_package表主键
//uid    varchar(36) NULL
//device_id    varchar(36) NULL
//upgrade_type    int(3) NULL    升级方式:0 系统推升级, 1 APP自动升级
//start_version    varchar(20) NULL    升级之前版本号
//end_version    varchar(20) NULL    升级之后版本号
//product_id    varchar(36) NULL
//status    int(3) NULL    升级状态: 1待升级 2下载中 3升级成功 4升级失败 5、升级超时
//code    varchar(12) NULL
//create_by    varchar(36) NULL    创建人
//create_time    timestamp NULL
//update_time    timestamp NULL
//del_flag    int(2) NULL
@interface TBDeviceUpgradeTask : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *upgradePackageId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) int upgradeType;
@property (nonatomic, copy) NSString *startVersion;
@property (nonatomic, copy) NSString *endVersion;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;
@end
