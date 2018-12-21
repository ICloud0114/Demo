//
//  ModifyUserAccountCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/27.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface ModifyUserAccountCmd : TBBaseCmd

+ (instancetype)instanceWithNewAccount:(NSString *)nAccount;
@property (nonatomic, copy) NSString *nPhone;
@property (nonatomic, copy) NSString *nEmail;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL checkEmailCode;
@property (nonatomic, copy) NSString *password;

@end
NS_ASSUME_NONNULL_END
