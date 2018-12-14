//
//  NSUserDefaults+Cache.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/21.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (Cache)

@property (nonatomic, copy) NSString *apnsToken;

@end

static inline NSUserDefaults *UserDefaults() {
    return NSUserDefaults.standardUserDefaults;
}

static inline void UserDefaultsSave(NSString *key, id _Nullable value) {
    [UserDefaults() setObject:value forKey:key];
}

static inline id UserDefaultsValue(NSString *key) {
    return [UserDefaults() objectForKey:key];
}
NS_ASSUME_NONNULL_END
