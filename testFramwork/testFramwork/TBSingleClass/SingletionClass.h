//
//  SingletionClass.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/8.
//  Copyright © 2017年 orvibo. All rights reserved.
//

#ifndef SingletionClass_h
#define SingletionClass_h

#define Singleton() \
                    static id __singletion__;\
                    static dispatch_once_t onceToken;\
                    dispatch_once(&onceToken, ^{\
                        __singletion__ =[[self alloc] init];\
                    });\
                    return __singletion__

#endif /* SingletionClass_h */
