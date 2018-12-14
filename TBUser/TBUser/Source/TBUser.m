//
//  TBUser.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/17.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBUser.h"
#import "TBAccount+TableCoding.h"
#import "TBLocalAccount+TableCoding.h"
#import "TBReadTableManager.h"
#import <MJExtension/MJExtension.h>
#import "TBLogoutCmd.h"
#import "TBTokenReportCmd.h"
#import "TBModifyAccountNicknameCmd.h"
#import "TBGeneratorCodeCmd.h"
#import "TBRegisterAccountCmd.h"
#import "TBResetPasswordCmd.h"
#import "TBModifyPasswordCmd.h"

@interface TBUser()
@property (nonatomic, strong) TBLocalAccount *localAccount;
@property (nonatomic, strong) TBAccount *account;

@property (nonatomic, assign) BOOL unFirstLogin;
@property (nonatomic, copy) NSString *apnsToken;
@end

@implementation TBUser

#pragma mark - Public Method
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
              completion:(TBCloudRequestCompleteBlock)block {
    __weak typeof(self) weakSelf = self;
    [self _loginWithAccount:account passwordMd5:md5WithStr(password) completion:^(TBResponse * _Nonnull response) {
        if (response.status == TBStatusSuccess) {
            [weakSelf _syncTableDataAfterLoginWithLoginResponse:response Completion:^(TBResponse * _Nonnull response) {
                if (response.status != TBStatusSuccess) {
                    DLog(@"登录是，发送读表失败，因此把登录状态改为未登录状态👌");
                    [weakSelf localLogout];
                }
                block(response);
            }];
        } else {
            block(response);
        }
    }];
}

- (void)autoLoginWihtCompletion:(TBCloudRequestCompleteBlock)block {
    if (self.isLogin && self.localAccount) {
        __weak typeof(self) weakSelf = self;
        [self _loginWithAccount:self.localAccount.account passwordMd5:self.localAccount.password completion:^(TBResponse *response) {
            if (block) {
                block(response);
            }
            [weakSelf _syncTableDataAfterLoginWithLoginResponse:response Completion:^(TBResponse *response) {
                DLog(@"自动登录--同步数据:<%@>", response.status == TBStatusSuccess? @"成功": @"失败");
                if (response.status == TBStatusSuccess) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:TBUserLocalDataUpdateNotification object:nil userInfo:nil];
                }
            }];
        }];
    }
}

- (void)logoutWithCompletion:(TBCloudRequestCompleteBlock)block {
    TBLogoutCmd *cmd = [TBLogoutCmd cmdInstance];
    cmd.account = self.localAccount.account;
    if (self.apnsToken) {
        cmd.token = self.apnsToken;
    }
    sendCmd(cmd, ^(TBResponse *response) {
        if (response.status == TBStatusSuccess) {
            [self.localAccount deleteLocalAccount];
            self.localAccount = nil;
            self.account = nil;
            [[TBCmdRouter shareInstance] didLogout];
        }
        block(response);
    });
}

- (void)modifyNickName:(NSString *)nickName completion:(TBCloudRequestCompleteBlock)block {
    TBModifyAccountNicknameCmd *cmd = [TBModifyAccountNicknameCmd cmdInstance];
    cmd.userId = self.userId;
    cmd.nickname = nickName;
    __weak typeof(self) weakSelf = self;
    sendCmd(cmd, ^(TBResponse *response) {
        if (response.status == TBStatusSuccess) {
            [weakSelf.account updateNickname:nickName];
        }
        block(response);
    });
}

- (void)generatorCodeWithAccount:(NSString *)account type:(TBGeneratorCodeType)type completion:(TBCloudRequestCompleteBlock)block {
    NSAssert(account, @"account不能为空");
    TBGeneratorCodeCmd *cmd;
    if (isPhoneNumber(account)) {
        cmd = [TBGeneratorCodeCmd instanceGeneratorCodeCmdWithPhone:account];
    } else {
        cmd = [TBGeneratorCodeCmd instanceGeneratorCodeCmdWithEmail:account];
    }
    cmd.type = type;
    sendCmd(cmd, block);
}

- (void)registerWithAccount:(NSString *)account code:(NSString *)code password:(NSString *)password completion:(TBCloudRequestCompleteBlock)block {
    NSAssert(account, @"account不能为空");
    TBRegisterAccountCmd *cmd = [TBRegisterAccountCmd instanceWithAccount:account];
    cmd.checkEmailCode = (code != nil);
    cmd.code = code;
    cmd.password = md5WithStr(password);
    sendCmd(cmd, block);
}

- (void)resetPasswordWithAccount:(NSString *)account code:(NSString *)code password:(nonnull NSString *)password completion:(nonnull TBCloudRequestCompleteBlock)block {
    NSAssert(account, @"account不能为空");
    TBResetPasswordCmd *cmd = [TBResetPasswordCmd instanceWithAccount:account];
    cmd.code = code;
    cmd.password = md5WithStr(password);
    sendCmd(cmd, block);
}

- (void)modifyPasswordWithOldPassword:(NSString *)oPassword newPassword:(NSString *)nPassowrd completion:(TBCloudRequestCompleteBlock)block {
    TBModifyPasswordCmd *cmd = [TBModifyPasswordCmd cmdInstance];
    cmd.userId = self.userId;
    cmd.oPassword = md5WithStr(oPassword);
    cmd.nPassword = md5WithStr(nPassowrd);
    __weak typeof(self) weakSelf = self;
    sendCmd(cmd, ^(TBResponse * _Nonnull response) {
        if (response.status == TBStatusSuccess) {
            NSString *nPwd = md5WithStr(nPassowrd);
            [weakSelf.localAccount updatePassword:nPwd];
            [weakSelf.account updatePassword:nPwd];
            TBLoginCmd *cmd = (TBLoginCmd *)[[TBCmdRouter shareInstance] loginCmdWithUid:nil];
            cmd.password = nPwd;
        }
        block(response);
    });
}

#pragma mark - Internal Method
- (void)localLogout {
    dispatch_async_main(^{
        [self.localAccount deleteLocalAccount];
        self.localAccount = nil;
        self.account = nil;
        [[TBCmdRouter shareInstance] didLogout];
    });
}

- (void)_loginWithAccount:(NSString *)account passwordMd5:(NSString *)pwdMd5 completion:(TBCloudRequestCompleteBlock)block {
    NSAssert(account, @"account不能为空");
    TBLoginCmd *cmd = [TBLoginCmd instanceWithAccount:account];
    cmd.password = pwdMd5;
    cmd.type = 0;
    __weak typeof(self) weakSelf = self;
    sendCmd(cmd, ^(TBResponse *response) {
        if (response.status == TBStatusSuccess) {
            [weakSelf saveLocalAccount:account password:pwdMd5 userId:response.result[@"uid"]];
            [weakSelf saveAccountInfo:response.result password:pwdMd5];
            weakSelf.unFirstLogin = YES;
        }
        block(response);
    });
}

- (void)_syncTableDataAfterLoginWithLoginResponse:(TBResponse *)loginResponse Completion:(TBCloudRequestCompleteBlock)block {
    [[TBReadTableManager share] readAllTables:^(TBResponse *res) {
        if (res.status == TBStatusSuccess) {
            block(loginResponse);
        } else {
            block([[TBResponse alloc] initWithStatus:TBStatusFailed result:nil]);
        }
    }];
}

#pragma mark - SAVE
- (void)saveLocalAccount:(NSString *)account password:(NSString *)password userId:(NSString *)userId {
    if (!self.isAutoLogin) {
        TBLocalAccount *localAccount = [[TBLocalAccount alloc] init];
        localAccount.userId = userId;
        if ([localAccount deleteLocalAccount]) {
            DLog(@"非自动登录下，删除本地账号成功");
        }
        return;
    }
    TBLocalAccount *localAccount = [TBLocalAccount new];
    localAccount.account = account;
    localAccount.password = password;
    localAccount.userId = userId;
    localAccount.loginTime = [[NSDate date] timeIntervalSince1970];
    if ([localAccount insertObject]) {
        self.localAccount = localAccount;
    }
}

- (void)saveAccountInfo:(NSDictionary *)info password:(NSString *)password {
    TBAccount *account = [TBAccount mj_objectWithKeyValues:info];
    account.password = self.localAccount.password;
    BOOL result = [account insertObject];
    DLog(@"保存用户信息%@", result? @"成功": @"失败");
}

#pragma mark - Action
- (void)tSmartSdkAsyncNotification:(NSNotification *)notification {
    NSNumber *cmd = notification.object;
    if (cmd.integerValue != [TBLoginCmd cmdInstance].cmd) {
        return;
    }
    if (self.apnsToken) {
        TBTokenReportCmd *cmd = [TBTokenReportCmd cmdInstance];
        cmd.phoneToken = self.apnsToken;
        sendCmd(cmd, ^(TBResponse *response) {
            DLog(@"上传APNS token%@", response.status == TBStatusSuccess? @"成功": @"失败");
        });
    }
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static TBUser *user = nil;
    dispatch_once(&onceToken, ^{
        user = [[TBUser alloc] init];
    });
    return user;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isAutoLogin = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tSmartSdkAsyncNotification:) name:NOTIFICATION_ASYNC_RECEIVE_DATA object:nil];
    }
    return self;
}

#pragma mark - getter setter
- (BOOL)isLogin {
    return (self.localAccount != nil);
}

- (NSString *)nickname {
    return self.account.nickName;
}

- (NSString *)headPortraitUrl {
    return self.account.headImage;
}

- (NSString *)email {
    return self.account.email;
}

- (NSString *)phone {
    return self.account.phone;
}

- (TBAccount *)account {
    if (!self.userId) {
        _account = nil;
        return nil;
    }
    if (!_account) {
        _account = [TBAccount instanceWithUserId:self.userId];
    }
    return _account;
}

- (TBLocalAccount *)localAccount {
    if (!_localAccount) {
        _localAccount = [TBLocalAccount lastAccountInfo];
    }
    return _localAccount;
}

- (NSString *)userId {
    return self.localAccount.userId;
}

@end

@implementation TBUser (Application)

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    if (self.localAccount != nil) {
        TBLoginCmd *cmd = [TBLoginCmd instanceWithAccount:self.localAccount.account];
        cmd.password = self.localAccount.password;
        [[TBCmdRouter shareInstance] autoLogin:cmd];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [TBSmartSDK setAppBackground:NO];
    if (self.isLogin && self.unFirstLogin && isNetwrokEnable()) { //进入前台后，如果为自动登录就进行自动登录
        [self autoLoginWihtCompletion:nil];
    }

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [TBSmartSDK setAppBackground:YES];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    self.apnsToken = convertDataToHexStr(deviceToken);
}

@end

