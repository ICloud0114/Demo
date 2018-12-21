//
//  ResetPasswordCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//
//重置(忘记)密码


NS_ASSUME_NONNULL_BEGIN
@interface ResetPasswordCmd : TBBaseCmd

+ (instancetype)instanceWithAccount:(NSString *)account;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *password; //md5值

@end
NS_ASSUME_NONNULL_END
