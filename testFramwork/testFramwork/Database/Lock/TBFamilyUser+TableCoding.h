//
//  TBFamilyUser+TableCoding.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/4/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBFamilyUser.h"
#import "TableCoding.h"

@interface TBFamilyUser (TableCoding) <TableCoding>

+ (BOOL)updateNickName:(NSString *)nickName withUid:(NSString *)uid userId:(NSString *)userId;

+ (BOOL)removeLocalShareUserWithUserId:(NSString *)userId uid:(NSString *)uid;
@end
