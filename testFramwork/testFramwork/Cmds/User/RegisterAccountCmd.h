//
//  RegisterAccountCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface RegisterAccountCmd : TBBaseCmd

@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy) NSString *password; //密码md5值
 //邮箱注册的时候是否校验邮箱验证码
@property (nonatomic, assign) BOOL checkEmailCode;
@property (nonatomic, copy) NSString *code; //验证码

+ (instancetype)instanceWithAccount:(NSString *)account;
@end
NS_ASSUME_NONNULL_END
