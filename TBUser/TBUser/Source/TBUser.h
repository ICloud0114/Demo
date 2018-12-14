//
//  TBUser.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/17.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLocalAccount.h"
#import "TBAccount.h"
#import <tSmartSDK/tSmartSDK.h>
#import "TBUserNotifications.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TBGeneratorCodeType) {
    kGeneratorRegisterCode = 0, //获取注册验证码
    kGeneratorResetPasswordCode = 1, //获取重置密码验证码
    kGeneratorForgotPasswordCode = 2, //获取忘记密码验证码
    kGeneratorModifyAccountCode = 3 //获取修改账号的验证码
};

@interface TBUser : NSObject

+ (instancetype)shareInstance;

//用户id
@property (nonatomic, copy, nullable, readonly) NSString *userId;
//当前用户最后一次登录的登录信息
@property (nonatomic, strong, nullable, readonly) TBLocalAccount *localAccount;
//用户昵称
@property (nonatomic, copy, readonly) NSString *nickname;
//头像url
@property (nonatomic, copy, readonly) NSString *headPortraitUrl;
//邮箱
@property (nonatomic, copy, nullable, readonly) NSString *email;
//手机号
@property (nonatomic, copy, nullable, readonly) NSString *phone;
//当前用户账号信息
@property (nonatomic, strong, nullable, readonly) TBAccount *account;
//是否登录
@property (nonatomic, assign, readonly) BOOL isLogin;
//是否自动登录,默认为YES
@property (nonatomic, assign) BOOL isAutoLogin;

- (void)loginWithAccount:(NSString *)account password:(NSString *)password completion:(TBCloudRequestCompleteBlock)block;

//isLogin为YES的时候可调用此接口进行快速登录
- (void)autoLoginWihtCompletion:(TBCloudRequestCompleteBlock _Nullable)block;

/**
 登出
 
 @param block 回调
 */
- (void)logoutWithCompletion:(TBCloudRequestCompleteBlock)block;

/**
 修改用户昵称
 
 @param nickName 新昵称
 @param block 回调
 */
- (void)modifyNickName:(NSString *)nickName completion:(TBCloudRequestCompleteBlock)block;

/**
 根据账号获取验证码
 
 @param account 可为邮箱和手机号
 @param type 获取验证码用途
 @param block 回调
 */
- (void)generatorCodeWithAccount:(NSString *)account type:(TBGeneratorCodeType)type completion:(TBCloudRequestCompleteBlock)block;

/**
 账号注册
 
 @param account 可为手机号和邮箱
 @param code 验证码
 @param password 密码
 @param block 回调
 */
- (void)registerWithAccount:(NSString *)account code:(NSString * _Nullable)code password:(NSString *)password completion:(TBCloudRequestCompleteBlock)block;

/**
 重置密码
 
 @param account 可为手机号和邮箱
 @param code 验证码
 @param password 新密码
 */
- (void)resetPasswordWithAccount:(NSString *)account code:(NSString *)code password:(NSString *)password completion:(TBCloudRequestCompleteBlock)block;

/**
 修改密码
 
 @param oPassword 旧密码
 @param nPassowrd 新密码
 */
- (void)modifyPasswordWithOldPassword:(NSString *)oPassword newPassword:(NSString *)nPassowrd completion:(TBCloudRequestCompleteBlock)block;
@end

//此分类实现UIApplicationDelegate
@interface TBUser (Application) <UIApplicationDelegate>
- (void)applicationDidFinishLaunching:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
@end
NS_ASSUME_NONNULL_END
