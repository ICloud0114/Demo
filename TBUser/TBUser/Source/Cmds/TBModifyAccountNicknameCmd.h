//
//  TBModifyAccountNicknameCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBModifyAccountNicknameCmd : TBBaseCmd

@property (nonatomic, copy) NSString *userId; //用户id
@property (nonatomic, copy) NSString *nickname; //昵称

@end
