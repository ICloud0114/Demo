//
//  TBDevice+TableCoding.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/27.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBDevice.h"
#import "TableCoding.h"

@interface TBDevice (TableCoding) <TableCoding>

+ (BOOL)updateName:(NSString *)name forDevice:(NSString *)deviceId;

+ (BOOL)deleteWithDeviceId:(NSString *)deviceId;

+ (BOOL)deleteWithDeviceUid:(NSString *)uid;

+ (NSDictionary *)allDeviceNameValuesAndDeviceIdKey;

+ (NSString *)deviceIdWithUid:(NSString *)uid;
@end
