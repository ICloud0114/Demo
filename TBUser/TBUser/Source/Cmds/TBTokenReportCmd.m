//
//  TBTokenReportCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBTokenReportCmd.h"

@implementation TBTokenReportCmd

- (NSString *)language {
    return @"chinese";
}

- (NSString *)os {
    return @"iOS";
}

- (NSInteger)cmd {
    return 38;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.language forKey:@"language"];
    [sendValue setObject:self.os forKey:@"os"];
    [sendValue setObject:self.phoneToken forKey:@"phoneToken"];
    return sendValue;
}

@end
