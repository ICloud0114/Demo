//
//  DeleteLockUserCmd.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/5.
//  Copyright © 2018年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface DeleteLockUserCmd : TBBaseCmd

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *deviceId;

@end
NS_ASSUME_NONNULL_END
