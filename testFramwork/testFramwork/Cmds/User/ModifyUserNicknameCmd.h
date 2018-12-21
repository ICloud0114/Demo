//
//  ModifyUserNicknameCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/26.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface ModifyUserNicknameCmd : TBBaseCmd

@property (nonatomic, copy) NSString *userId; //用户id
@property (nonatomic, copy) NSString *nickname; //昵称

@end
NS_ASSUME_NONNULL_END
