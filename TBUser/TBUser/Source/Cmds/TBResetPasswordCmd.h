//
//  TBResetPasswordCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBResetPasswordCmd : TBBaseCmd
+ (instancetype)instanceWithAccount:(NSString *)account;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *password; //md5值
@end
