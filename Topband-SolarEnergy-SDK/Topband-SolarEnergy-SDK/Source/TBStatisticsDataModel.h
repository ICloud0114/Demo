//
//  TBStatisticsDataModel.h
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/19.
//  Copyright © 2018年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TBStatisticsDataModel : NSObject

@property (nonatomic, copy) NSString *point; //时间点
@property (nonatomic, copy) NSNumber *value; //值

@end
NS_ASSUME_NONNULL_END
