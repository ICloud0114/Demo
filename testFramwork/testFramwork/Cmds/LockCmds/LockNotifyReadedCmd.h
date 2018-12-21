//
//  LockNotifyReadedCmd.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/5/31.
//  Copyright © 2018年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface LockNotifyReadedCmd : TBBaseCmd

@property (nonatomic, copy) NSString *phoneToken;
@property (nonatomic, assign) int num;
@end
NS_ASSUME_NONNULL_END
