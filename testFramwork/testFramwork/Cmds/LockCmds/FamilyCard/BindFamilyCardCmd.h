//
//  BindFamilyCardCmd.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface BindFamilyCardCmd : TBBaseCmd
@property (nonatomic, assign) int checkOnline;
@property (nonatomic, copy) NSString *deviceName;
@end
NS_ASSUME_NONNULL_END
