//
//  TBLogoutCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBLogoutCmd.h"

@implementation TBLogoutCmd

- (NSInteger)cmd {
    return 43;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.account forKey:@"account"];
    if (self.token) {
        [sendValue setObject:self.token forKey:@"token"];
    }
    return sendValue;
}

- (BOOL)loginIfNeed {
    return YES;
}
@end
