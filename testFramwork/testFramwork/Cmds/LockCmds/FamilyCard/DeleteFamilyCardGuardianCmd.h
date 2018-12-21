//
//  DeleteFamilyCardGuardianCmd.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN
@interface DeleteFamilyCardGuardianCmd : TBBaseCmd
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *phone;
@end
NS_ASSUME_NONNULL_END
