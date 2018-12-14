//
//  TBMessagePullObject.h
//  TBUser
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBMessagePullObject <NSObject>

+ (NSString *)maxUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId; //获取当前表的最大更新时间
+ (NSString *)minUpdateTimeWithUserId:(NSString *)userId uid:(NSString *)uid deviceId:(NSString *)deviceId;; //获取当前表的最小更新时间

@end
