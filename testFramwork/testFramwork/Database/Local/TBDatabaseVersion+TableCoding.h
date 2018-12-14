//
//  TBDatabaseVersion+TableCoding.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/3/14.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBDatabaseVersion.h"
#import "TableCoding.h"

@interface TBDatabaseVersion (TableCoding) <TableCoding>

+ (TBDatabaseVersion *)oldVersion;

+ (BOOL)saveCurrentDatabaseVersion;
@end
