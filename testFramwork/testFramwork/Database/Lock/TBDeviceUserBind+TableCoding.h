//
//  TBDeviceUserBind+TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/29.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDeviceUserBind.h"
#import "TableCoding.h"

@interface TBDeviceUserBind (TableCoding) <TableCoding>

+ (BOOL)deleteWithUserId:(NSString *)userId deviceId:(NSString *)deviceId;

@end
