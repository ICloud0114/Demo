//
//  TokenReportCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/21.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TokenReportCmd.h"

@implementation TokenReportCmd

- (NSString *)language {
    return @"chinese";
}

- (NSString *)os {
    return @"iOS";
}

- (NSInteger)cmd {
    return TOPBAND_CMD_TR;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.language forKey:@"language"];
    [sendValue setObject:self.os forKey:@"os"];
    [sendValue setObject:self.phoneToken forKey:@"phoneToken"];
    return sendValue;
}
@end
