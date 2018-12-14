//
//  TBSolarEnergySDK.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBSolarEnergySDK.h"
#import <TBDataBase/TBDatabaseManager.h>
#import <Topband_Cloud_TBUser/TBUser.h>
#import <Topband_Cloud_Device/TBDeviceManager.h>
#import "TBSolarEnergyTables.h"

@implementation TBSolarEnergySDK

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static TBSolarEnergySDK *sdk = nil;
    dispatch_once(&onceToken, ^{
        sdk = [TBSolarEnergySDK new];
    });
    return sdk;
}

//是否使用测试服务器
- (void)setServer:(TBServerUrl)server {
    [TBSmartSDK setServerUrl:server];
}

//设置app名称
- (void)setAppName:(NSString *)appName {
    [TBSmartSDK setAppName:appName];
}

//设置企业ID
- (void)setCompanyId:(NSString *)companyId {
    [TBSmartSDK setCompanyId:companyId];
}

//是否打印日志
- (void)setDebugEnable:(BOOL)enable {
    [TBSmartSDK setDebugEnable:enable];
}

- (void)launch {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BOOL isNewVersion = [[TBDatabaseManager shareInstance] initDatabaseWithTables:[TBSolarEnergyTables class]];
        if (isNewVersion) {
            //清除一些读表相关的操作
        }
        [TBDeviceManager share];
        [TBSmartSDK launch];
    });
}

#pragma mark - UIApplicationDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [[TBUser shareInstance] applicationDidFinishLaunching:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[TBUser shareInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[TBUser shareInstance] applicationDidEnterBackground:application];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[TBUser shareInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

@end
