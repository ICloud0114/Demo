//
//  TBLogoutCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBLogoutCmd : TBBaseCmd

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *token;

@end
