//
//  QueryDataCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBQueryDataCmd.h"

@implementation TBQueryDataCmd

- (NSInteger)cmd {
    return 27;
}

- (NSDictionary *)payload {
    if (self.uid) { [sendValue setObject:self.uid forKey:@"uid"]; }
    if (self.deviceId) { [sendValue setObject:self.deviceId forKey:@"deviceId"]; }
    [sendValue setObject:self.tableName forKey:@"tableName"];
    [sendValue setObject:@(self.pageIndex) forKey:@"pageIndex"];
    [sendValue setObject:@(self.updateTime) forKey:@"updateTime"];
    return sendValue;
}

- (BOOL)loginIfNeed {
    return YES;
}

@end
