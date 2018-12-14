//
//  Tables.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/28.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCoding.h"
#import "TBDatabaseVersion+TableCoding.h"

@interface Tables : NSObject

//服务器表
+ (NSArray<Class<TableCoding>> *)serverTables;
//本地表
+ (NSArray<Class<TableCoding>> *)localTables;

@end
