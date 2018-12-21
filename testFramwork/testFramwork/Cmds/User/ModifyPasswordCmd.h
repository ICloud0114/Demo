//
//  ModifyPasswordCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/15.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface ModifyPasswordCmd : TBBaseCmd

@property (nonatomic, copy) NSString *userId; //用户ID
@property (nonatomic, copy) NSString *oPassword;
@property (nonatomic, copy) NSString *nPassword;

@end
NS_ASSUME_NONNULL_END
