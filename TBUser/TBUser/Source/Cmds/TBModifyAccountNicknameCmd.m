//
//  TBModifyAccountNicknameCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBModifyAccountNicknameCmd.h"

@implementation TBModifyAccountNicknameCmd

- (NSInteger)cmd {
    return 20;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"uid"];
    [sendValue setObject:self.nickname forKey:@"nickName"];
    return sendValue;
}

- (BOOL)loginIfNeed {
    return YES;
}

@end
