//
//  DeviceShareConfirmCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/28.
//  Copyright © 2017年 topband. All rights reserved.
//


@interface DeviceShareConfirmCmd : TBBaseCmd

@property (nonatomic, copy) NSString *inviteId;

/**
 1：接受邀请
 2：拒绝邀请
 */
@property (nonatomic, assign) int type;

@end
