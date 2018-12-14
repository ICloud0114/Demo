//
//  Constant.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/17.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "Constant.h"
//内网
//
//1、192.168.3.50
//2、web.topband.com.cn
//
//外网
//1、access.topband-cloud.com ---发布环境
//2、121.15.200.118 ---测试环境
NSString *const SERVER_DOMAIN = @"121.15.200.118";
uint16_t const SERVER_PORT = 10001;
NSString *const PUBLICAEC128KEY = @"topgd54865SNBAND";
NSString *const DATABASE_NAME = @"tSmart.db";
NSString *const DATABASE_VERSION = @"1.0.3";

NSTimeInterval const HeartBeatTime = (3 * 60);        // 心跳包发送的时间间隔
