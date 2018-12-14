//
//  TBDatabaseVersion.h
//  tSmartSDK-SmartLock
//
//  Created by Topband on 2018/3/14.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBDatabaseVersion : NSObject

@property (nonatomic, assign) int versionId;
@property (nonatomic, copy) NSString *version;

@end
