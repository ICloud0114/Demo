//
//  UpdateCardPhoneCmd.h
//  tSmartSDK-SmartLock
//
//  Created by ICloud on 2018/8/1.
//  Copyright © 2018年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface UpdateCardPhoneCmd : TBBaseCmd
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *phone; 
@property (nonatomic, copy) NSString *phoneName;
@end
NS_ASSUME_NONNULL_END
