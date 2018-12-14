//
//  TBSolarEnergySDK.h
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <tSmartSDK/tSmartSDK.h>

@interface TBSolarEnergySDK : NSObject <UIApplicationDelegate>
+ (instancetype)share;

//是否使用测试服务器
- (void)setServer:(TBServerUrl)server;
//设置app名称
- (void)setAppName:(NSString *)appName;
//设置企业ID
- (void)setCompanyId:(NSString *)companyId;
//是否打印日志
- (void)setDebugEnable:(BOOL)enable;

- (void)launch;
@end
