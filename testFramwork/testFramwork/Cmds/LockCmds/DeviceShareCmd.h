//
//  DeviceShareCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//
//设备分享


NS_ASSUME_NONNULL_BEGIN
@interface DeviceShareCmd : TBBaseCmd

+ (instancetype)instanceWithInviteAccount:(NSString *)iAccount;
@property (nonatomic, copy) NSString *iPhone;
@property (nonatomic, copy) NSString *iEmail;
@property (nonatomic, copy) NSString *deviceId;

@end
NS_ASSUME_NONNULL_END
