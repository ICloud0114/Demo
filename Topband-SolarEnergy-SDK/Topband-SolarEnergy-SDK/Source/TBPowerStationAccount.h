//
//  TBPowerStationAccount.h
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBPowerStationAccount : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *powerStationId;
@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) int delFlag;

@end
