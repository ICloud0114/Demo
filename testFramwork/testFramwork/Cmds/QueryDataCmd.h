//
//  QueryDataCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//
//读表接口


NS_ASSUME_NONNULL_BEGIN
@interface QueryDataCmd : TBBaseCmd

@property (nonatomic, assign) int updateTime;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, assign) int pageIndex;

@end
NS_ASSUME_NONNULL_END
