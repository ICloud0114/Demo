//
//  TBModifyPasswordCmd.m
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBModifyPasswordCmd.h"

@implementation TBModifyPasswordCmd

- (NSInteger)cmd {
    return 21;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.userId forKey:@"uid"];
    [sendValue setObject:self.oPassword forKey:@"oldPassword"];
    [sendValue setObject:self.nPassword forKey:@"newPassword"];
    return sendValue;
}

- (BOOL)loginIfNeed {
    return YES;
}

@end
