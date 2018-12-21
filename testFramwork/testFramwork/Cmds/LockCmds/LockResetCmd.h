//
//  LockResetCmd.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/2/25.
//  Copyright © 2018年 topband. All rights reserved.
//
//锁恢复出厂设置接口


NS_ASSUME_NONNULL_BEGIN
@interface LockResetCmd : TBBaseCmd

@property (nonatomic, copy) NSString *resettingId;

@end
NS_ASSUME_NONNULL_END
