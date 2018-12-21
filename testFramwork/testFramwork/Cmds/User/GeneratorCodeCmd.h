//
//  GeneratorCodeCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface GeneratorCodeCmd: TBBaseCmd

//用手机号生成验证码
+ (instancetype)instanceGeneratorCodeCmdWithPhone:(NSString *)phone;
//用邮箱生成验证码
+ (instancetype)instanceGeneratorCodeCmdWithEmail:(NSString *)email;

@property (nonatomic, copy, readonly) NSString *phone;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, assign) NSInteger type;

@end
NS_ASSUME_NONNULL_END
