//
//  TBGeneratorCodeCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBGeneratorCodeCmd : TBBaseCmd

//用手机号生成验证码
+ (instancetype)instanceGeneratorCodeCmdWithPhone:(NSString *)phone;
//用邮箱生成验证码
+ (instancetype)instanceGeneratorCodeCmdWithEmail:(NSString *)email;

@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, assign) NSInteger type;

@end
