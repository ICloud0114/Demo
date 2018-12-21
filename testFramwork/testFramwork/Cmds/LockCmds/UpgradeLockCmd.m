//
//  UpgradeLockCmd.m
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/7.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "UpgradeLockCmd.h"

@interface UpgradeLockCmd()

@property (nonatomic, copy) NSString *packageId;

@end

@implementation UpgradeLockCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_GFUC;
}

+ (instancetype)instanceUpgradeCodeCmdWithPackageId:(NSString *)pid{
    UpgradeLockCmd *cmd = [UpgradeLockCmd cmdInstance];
    cmd.packageId = pid;
    return cmd;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.packageId forKey:@"pkgId"];
    [sendValue setObject:self.deviceId forKey:@"deviceId"];
    return sendValue;
}
@end
