//
//  TBLocalAccount.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//
//代表当前登录的账号

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBLocalAccount : NSObject

@property (nonatomic, copy) NSString *userId; //用户id
@property (nonatomic, copy) NSString *account; //账号
@property (nonatomic, copy) NSString *password; //密码
@property (nonatomic, assign) int loginTime; //登录时间戳

@end
NS_ASSUME_NONNULL_END
