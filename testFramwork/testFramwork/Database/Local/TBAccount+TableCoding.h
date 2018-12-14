//
//  TBAccount+TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/18.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBAccount.h"
#import "TableCoding.h"

@interface TBAccount (TableCoding) <TableCoding>

+ (instancetype)instanceWithUserId:(NSString *)userId;

- (void)updateNickname:(NSString *)nickName;

- (void)updateHeadPortrait:(NSString *)url;

- (void)update;

- (BOOL)updatePassword:(NSString *)password;
@end
