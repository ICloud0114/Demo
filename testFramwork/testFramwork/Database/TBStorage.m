//
//  TBStorage.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/8.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#import "TBStorage.h"
#import "SingletionClass.h"

@implementation TBStorage

+ (instancetype)share {
    Singleton();
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _enableLog = YES;
    }
    return self;
}

@end
