//
//  UpgradeLockCmd.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN
@interface UpgradeLockCmd : TBBaseCmd

+ (instancetype)instanceUpgradeCodeCmdWithPackageId:(NSString *)pid;

@property (nonatomic, copy, readonly) NSString *packageId;
@property (nonatomic, copy) NSString *deviceId;

@end
NS_ASSUME_NONNULL_END
