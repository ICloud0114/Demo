//
//  TBAccount.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBAccount : NSObject

@property (nonatomic, copy) NSString *uid; //用户id
@property (nonatomic, nullable, copy) NSString *phone; //手机号
@property (nonatomic, nullable, copy) NSString *email; //邮箱
@property (nonatomic, copy) NSString *password; //密码
@property (nonatomic, copy) NSString *nickName; //昵称
@property (nonatomic, nullable, copy) NSString *headImage; //头像url
@property (nonatomic, nullable, copy) NSString *address;
@property (nonatomic, assign) int sex;
@property (nonatomic, nullable, copy) NSString *birthday;
@property (nonatomic, assign) int userType; //用户类型

@end
NS_ASSUME_NONNULL_END
