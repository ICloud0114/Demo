//
//  RequestTemporaryPasswordCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/26.
//  Copyright © 2017年 topband. All rights reserved.
//
//获取临时开锁密码


NS_ASSUME_NONNULL_BEGIN
@interface RequestTemporaryPasswordCmd : TBBaseCmd

@property (nonatomic, copy) NSString *deviceId; //设备deviceId
@property (nonatomic, assign) int type; //0:零时密码，1：限时密码，2：长期密码（默认1年时间）
@property (nonatomic, copy) NSString *startTime; //开始时间 2017/09/25 16:00 （限时密码才有用）
@property (nonatomic, copy) NSString *endTime; //结束时间  2017/09/30 16:00 （限时密码才有用）
@property (nonatomic, copy) NSString *phone; //客人电话
@property (nonatomic, copy) NSString *requestTime; //请求时间,yyyyMMddHHmmss
@property (nonatomic, copy) NSString *nickName;

@end
NS_ASSUME_NONNULL_END
