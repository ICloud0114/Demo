//
//  QueryDataUpOrDownCmd.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//
//上拉或下拉查询数据

#import <tSmartSDK/tSmartSDK.h>

@interface TBQueryDataUpOrDownCmd : TBBaseCmd

@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) int updateTime;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int type;

@end
