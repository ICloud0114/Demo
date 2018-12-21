//
//  CheckSMSCodeCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/30.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface CheckSMSCodeCmd : TBBaseCmd

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;

@end
NS_ASSUME_NONNULL_END
