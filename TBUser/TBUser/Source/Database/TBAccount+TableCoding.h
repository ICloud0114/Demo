//
//  TBAccount+TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBAccount.h"
#import <TBDataBase/TBTableCoding.h>

@interface TBAccount (TableCoding) <TBTableCoding>

+ (instancetype)instanceWithUserId:(NSString *)userId;

- (void)updateNickname:(NSString *)nickName;

- (void)updateHeadPortrait:(NSString *)url;

- (void)update;

- (BOOL)updatePassword:(NSString *)password;
@end
