//
//  UpdateDeviceNameCmd.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface UpdateDeviceNameCmd : TBBaseCmd

@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *deviceName;

@end
NS_ASSUME_NONNULL_END
