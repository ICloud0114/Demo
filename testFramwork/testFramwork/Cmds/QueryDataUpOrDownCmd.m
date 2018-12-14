//
//  QueryDataUpOrDownCmd.m
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "QueryDataUpOrDownCmd.h"

@implementation QueryDataUpOrDownCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_QDUOD;
}

- (NSDictionary *)payload {
    if (self.uid) { [sendValue setObject:self.uid forKey:@"uid"]; }
    if (self.deviceId) { [sendValue setObject:self.deviceId forKey:@"deviceId"]; }
    [sendValue setObject:@(self.updateTime) forKey:@"updateTime"];
    [sendValue setObject:self.tableName forKey:@"tableName"];
    [sendValue setObject:self.pageSize > 0? @(self.pageSize): @50 forKey:@"pageSize"];
    [sendValue setObject:@(self.type) forKey:@"type"];
    return sendValue;
}

@end
