//
//  TBStorage.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/8.
//  Copyright © 2017年 orvibo. All rights reserved.
//
//内存存储

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBStorage : NSObject

+ (instancetype)share;

@property (nonatomic, assign) BOOL enableLog;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *comanyId;
@property (nonatomic, assign, getter=isEnterBackground) BOOL enterBackground;
@property (nonatomic, assign) BOOL unFirstLogin; //是否非第一次登录

@end

static inline BOOL appIsEnterBackground(void) {
    return [TBStorage share].isEnterBackground;
}
NS_ASSUME_NONNULL_END
