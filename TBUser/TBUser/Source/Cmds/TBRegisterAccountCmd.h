//
//  TBRegisterAccountCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBRegisterAccountCmd : TBBaseCmd

@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy) NSString *password; //密码md5值
//邮箱注册的时候是否校验邮箱验证码
@property (nonatomic, assign) BOOL checkEmailCode;
@property (nonatomic, copy) NSString *code; //验证码

+ (instancetype)instanceWithAccount:(NSString *)account;

@end
