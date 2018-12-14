//
//  NSUserDefaults+Cache.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/21.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "NSUserDefaults+Cache.h"

@implementation NSUserDefaults (Cache)

- (void)setApnsToken:(NSString *)apnsToken {
    [[NSUserDefaults standardUserDefaults] setObject:apnsToken
                                              forKey:NSStringFromSelector(@selector(setApnsToken:))];
}

- (NSString *)apnsToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(@selector(setApnsToken:))];
}

@end
