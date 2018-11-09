//
//  WBCSandbox.h
//  KuaiChong
//
//  Created by Onliu on 14-6-8.
//  Copyright (c) 2014年 Onliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBCSandbox : NSObject
+ (NSFileManager *)myFileManager;
+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容

+ (NSString *)touch:(NSString *)path;//检查文件路径是否存在，不存在创建文件夹
+ (NSString *)findLastModifyFileInPath:(NSString *)path;//找出文件夹下最近修改的文件
@end
