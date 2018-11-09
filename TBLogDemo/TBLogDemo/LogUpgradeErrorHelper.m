//
//  LogUpgradeErrorHelper.m
//  ScmClient
//
//  Created by kevin on 17/2/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LogUpgradeErrorHelper.h"

//#import <iOAFramework/MacroUtil.h>
//#import <iOAFramework/DateUtil.h>
//#import <iOAFramework/FileManager.h>
//#import <iOAFramework/NSDate+date.h>

@interface LogUpgradeErrorHelper ()

@property (strong)  NSFileHandle *fileHandle ;
@property (copy)    NSString *logInfoPath ;
@property (copy)    NSString *logDate ;

@property (retain) dispatch_queue_t logQueue;

@property (strong) NSMutableDictionary *logInfos;

@property (copy)    NSString *currentLogName ;

@property (strong)    NSMutableDictionary *currentLogInfo ;


@end

@implementation LogUpgradeErrorHelper
//
//SHAREDINSTANCE(LogUpgradeErrorHelper);
//
//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        [self createLogPath];
//        
//        self.logQueue = dispatch_queue_create("com.tencent.log.ioaupgrade", DISPATCH_QUEUE_SERIAL);
//        
//        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:self.logInfoPath];
//        if (dic.count > 0)
//        {
//            self.currentLogInfo = [dic mutableCopy];
//            self.logInfos = [[dic objectForKey:@"info"] mutableCopy];
//            self.currentLogName = self.currentLogInfo[@"currentLogName"];
//        }
//        else
//        {
//            self.currentLogName = @"iOAUpgrade-Info-1.log";
//
//            self.currentLogInfo = [[NSMutableDictionary alloc] init];
//            self.logInfos = [[NSMutableDictionary alloc] init];
//
//            [self.logInfos setObject:@(0) forKey:@"iOAUpgrade-Info-1.log"];
//            [self.logInfos setObject:@(0) forKey:@"iOAUpgrade-Info-2.log"];
//            [self.logInfos setObject:@(0) forKey:@"iOAUpgrade-Info-3.log"];
//            
//            self.currentLogInfo[@"currentLogName"] = self.currentLogName;
//            self.currentLogInfo[@"info"] = self.logInfos;
//        }
//        [self initial];
//    }
//    return self;
//}
//
//- (void)initial
//{
//    NSString *path = [[self rootDirectory] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.currentLogName]];
//    
//    NSDictionary *attri = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//    unsigned long long size = [attri fileSize];
//    unsigned long long c_size = [[self.logInfos objectForKey:self.currentLogName] longLongValue];
//    if (size > c_size)
//    {
//        self.logInfos[self.currentLogName] = @(size);
//        self.currentLogInfo[@"info"] = self.logInfos;
//    }
//
//    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
//    
//    [self.fileHandle seekToEndOfFile];
//}
//
//- (NSString *)getCurrentLogName
//{
//    if ([self.currentLogName isEqualToString:@"iOAUpgrade-Info-1.log"])
//    {
//        return @"iOAUpgrade-Info-2.log";
//    }
//    else if ([self.currentLogName isEqualToString:@"iOAUpgrade-Info-2.log"])
//    {
//        return @"iOAUpgrade-Info-3.log";
//    }
//    else if ([self.currentLogName isEqualToString:@"iOAUpgrade-Info-3.log"])
//    {
//        return @"iOAUpgrade-Info-1.log";
//    }
//    return @"iOAUpgrade-Info-1.log";
//}
//
//- (void)writeLog:(NSString *)log type:(LogType)type
//{
//    dispatch_async(self.logQueue, ^{
//        
//        if (![self fileHandleAvailable])
//        {
//            [self.fileHandle closeFile];
//            
//            self.logInfos[self.currentLogName] = @(0);
//            
//            [self createFileHandle];
//        }
//        
//        NSInteger curLen = [self.logInfos[self.currentLogName] integerValue];
//        if (curLen > 5 * 1024 * 1024 )
//        {
//            [self.fileHandle closeFile];
//            
//            self.currentLogName = [self getCurrentLogName];
//            
//            self.logInfos[self.currentLogName] = @(0);
//            curLen = 0;
//            
//            [self createFileHandle];
//            
//            self.currentLogInfo[@"currentLogName"] = self.currentLogName;
//            
//        }
//        
//        NSString* dateString = [NSDate currentDateString];
//        
//        NSString *__log = [NSString stringWithFormat:@"%@: %s:[%d] : %@ \n",dateString,__PRETTY_FUNCTION__, __LINE__, log];
//        
//        TXLog(@"%@",__log);
//        
//        NSData *data = [__log dataUsingEncoding:NSUTF8StringEncoding];
//        
//        curLen = curLen + data.length;
//        self.logInfos[self.currentLogName] = @(curLen);
//        self.currentLogInfo[@"info"] = self.logInfos;
//        
//        [self.fileHandle writeData:data];
//        [self.fileHandle seekToEndOfFile]; //定位到尾部
//        
//        [self updateLocalLogInfo];
//    });
//    
//}
//
//- (void)updateLocalLogInfo
//{
//    [NSKeyedArchiver archiveRootObject:self.currentLogInfo toFile:self.logInfoPath];
//}
//
//
//- (void)createFileHandle
//{
//    NSString *path = [[self rootDirectory] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.currentLogName]];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
//    {
//        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//    }
//    
//    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
//
//    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
//    
//    [self.fileHandle seekToEndOfFile];
//}
//
//- (BOOL)fileHandleAvailable
//{
//    NSString *path = [[self rootDirectory] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.currentLogName]];
//    
//    NSFileManager *manager = [NSFileManager defaultManager];
//    
//    if ([manager fileExistsAtPath:path])
//    {
//        return YES;
//    }
//    
//    return NO;
//}
//
//- (NSString *)createLogPath
//{
//    NSString *rootDirectory = [self rootDirectory];
//        
//    NSString *fileName = [NSString stringWithFormat:@"iOAUpgrade-Info-1.log"];
//    
//    NSString *logPath_ = [[FileManager sharedInstance] createFilePathWithFileName:fileName directory:rootDirectory];
//    
//    fileName = [NSString stringWithFormat:@"iOAUpgrade-Info-2.log"];
//    
//    logPath_ = [[FileManager sharedInstance] createFilePathWithFileName:fileName directory:rootDirectory];
//
//    fileName = [NSString stringWithFormat:@"iOAUpgrade-Info-3.log"];
//    
//    logPath_ = [[FileManager sharedInstance] createFilePathWithFileName:fileName directory:rootDirectory];
//    
//    FileManager *manager = [FileManager sharedInstance];
//    NSString *logInfoDirectory = [manager createAppRootDirectory];
//    
//    self.logInfoPath = [manager createFilePathWithFileName:@"iOAUpgradeLogInfo.data" directory:logInfoDirectory];
//    
//    return logPath_;
//}
//
//- (NSString *)rootDirectory
//{
//    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSLocalDomainMask, false) firstObject];
//    
//    NSString *directory = [[FileManager sharedInstance] createDirectoryWithName:@"Logs" rootDirectory:rootPath];
//    
//    directory = [[FileManager sharedInstance] createDirectoryWithName:@"ScmClient" rootDirectory:directory];
////    directory = [[FileManager sharedInstance] createDirectoryWithName:@"v5" rootDirectory:directory];
//    directory = [[FileManager sharedInstance] createDirectoryWithName:@"iOACloud" rootDirectory:directory];
//    directory = [[FileManager sharedInstance] createDirectoryWithName:@"Logs" rootDirectory:directory];
//    
//    return directory;
//}


@end
