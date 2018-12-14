//
//  TBModifyPasswordCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBModifyPasswordCmd : TBBaseCmd

@property (nonatomic, copy) NSString *userId; //用户ID
@property (nonatomic, copy) NSString *oPassword;
@property (nonatomic, copy) NSString *nPassword;

@end
