//
//  TBLocalAccount+TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBLocalAccount.h"
#import <TBDataBase/TBTableCoding.h>

@interface TBLocalAccount (TableCoding) <TBTableCoding>

+ (instancetype)lastAccountInfo;

- (BOOL)deleteLocalAccount;

- (BOOL)updateAccount:(NSString *)account;

- (BOOL)updatePassword:(NSString *)password;
@end
