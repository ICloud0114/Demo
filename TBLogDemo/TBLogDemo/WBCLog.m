//
//  WBCLog.m
//  KuaiChong
//
//  Created by Onliu on 14-6-8.
//  Copyright (c) 2014年 Onliu. All rights reserved.
//

#import "WBCLog.h"
#import "WBCSandbox.h"
#import <UIKit/UIKit.h>

#define WBC_LOG_DEFAULT_LEVEL_TRIGGER   WBCLog_LEVEL_DEBUG
#define WBC_LOG_DEFAULT_COUNT_LIMIT     20
#define WBC_LOG_DEFAULT_SIZE_LIMIT      (1024 * 250)//250KB
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define APP_VERSION [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

#define WBC_LOG_FOLDER_NAME             @"wbclogs"


void uncaughtExceptionHandler(NSException *exception)
{
    [[WBCLog sharedInstance] processException:exception];
}


static dispatch_queue_t log2file_operation_processing_queue(){
    static dispatch_queue_t wbc_log2file_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wbc_log2file_operation_processing_queue = dispatch_queue_create("com.wbc.log2file_processiong", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return wbc_log2file_operation_processing_queue;
}

@interface WBCLog()
{
    NSInteger lastModifyLogIndex;
    NSString *crashPaths;
}
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSDateFormatter *carshDateFormatter;
@property (nonatomic,strong) NSString *logPaths;
- (BOOL)checkLogLevel:(WBCLog_LEVEL)level;
- (void)log2Console:(NSString *)log;
@end


@implementation WBCLog

+(void)load
{
    //注册异常捕获函数
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    NSLog(@"add uncaughtExceptionHandler");
}

+(instancetype)sharedInstance
{
    static WBCLog *_wbcLog;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _wbcLog=[[WBCLog alloc] init];
        _wbcLog.levelTrigger = WBC_LOG_DEFAULT_LEVEL_TRIGGER;
        _wbcLog.logSizeLimit = WBC_LOG_DEFAULT_SIZE_LIMIT;
        _wbcLog.logCountLimit= WBC_LOG_DEFAULT_COUNT_LIMIT;
        
        
    });
    return _wbcLog;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initLogPaths];
    }
    return self;
}

-(NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    }
    
    return _dateFormatter;
}

-(NSDateFormatter *)carshDateFormatter
{
    if (!_carshDateFormatter) {
        _carshDateFormatter = [[NSDateFormatter alloc] init];
        [_carshDateFormatter setDateFormat:@"yyyyMMdd_HHmmss_SSS"];
    }
    
    return _carshDateFormatter;
}

-(void)initLogPaths
{
    if (!_logPaths) {
        _logPaths = [[WBCSandbox docPath] stringByAppendingPathComponent:WBC_LOG_FOLDER_NAME];
        crashPaths = [_logPaths stringByAppendingPathComponent:@"crashReport"];
        [WBCSandbox touch:_logPaths];
        [WBCSandbox touch:crashPaths];
        
        lastModifyLogIndex = [self findLastModifyLogIndex];
        
        [self dateFormatter];
        [self carshDateFormatter];
    }
}


-(NSInteger)findLastModifyLogIndex
{
    NSString *lastFilePath = [WBCSandbox findLastModifyFileInPath:self.logPaths];
    if (lastFilePath) {
        NSString *fileName = [lastFilePath lastPathComponent];
        NSString *indexStr = [fileName substringWithRange:NSMakeRange(@"log".length, [fileName length]-3-4)];
        if ([indexStr length] > 0) {
           return [indexStr integerValue];
        }
    }
    return 1;
}

- (NSString *)level2String:(WBCLog_LEVEL)level
{
    NSString *logLevel;
    switch (level) {
        case WBCLog_LEVEL_DEBUG:
        {
            logLevel = @"D";
        }
            break;
        case WBCLog_LEVEL_INFO:
        {
            logLevel = @"I";
        }
            break;
        case WBCLog_LEVEL_WARN:
        {
            logLevel = @"W";
        }
            break;
        case WBCLog_LEVEL_ERROR:
        {
            logLevel = @"E";
        }
            break;
        case WBCLog_LEVEL_FATAL:
        {
            logLevel = @"F";
        }
            break;
            
            
        default:
            break;
    }
    return logLevel;
}

-(void)Log:(WBCLog_LEVEL)level message:(NSString *)msg classObject:(id)classObj file:(const char *)file function:(const char *)func line:(const unsigned int)line
{

    NSString *filePath = [NSString stringWithCString:file encoding:NSUTF8StringEncoding];
    NSString *logLevel;
    logLevel = [self level2String:level];

    //打印日志到控制台
    [self log2Console:[NSString stringWithFormat:@"%@ %@:%u %s %@",
                       logLevel, [filePath lastPathComponent], line, func, msg]];
    
    // check log level
//    if (isSimulator ||
//        [self checkLogLevel:level] == NO ) {
//        return;
//    }
    
    dispatch_async(log2file_operation_processing_queue(), ^{
        NSString *log = [NSString stringWithFormat:@"%@ %@ %@:%u %s %@",
                         [self.dateFormatter stringFromDate:[NSDate date]],
                         logLevel,
                         [filePath lastPathComponent],
                         line,
                         func,
                         msg];
        [self log2FileMessage:log];
    });
}

- (BOOL)checkLogLevel:(WBCLog_LEVEL)level
{
    return (self.levelTrigger <= level);
}

- (void)log2Console:(NSString *)log
{
//#warning Debug
    #ifdef DEBUG
    NSLog(@"%@", log);
    #endif
}

- (BOOL)log2FileMessage:(NSString *)log
{

    FILE *fd = [self shouldWriteFile];

    if (fd == NULL) {
        NSLog(@"open log file failed.");
        return NO;
    }
    
    fputs([log cStringUsingEncoding:NSUTF8StringEncoding], fd);
    fputs("\r\n", fd);
    fflush(fd);
    fclose(fd);
    return YES;
}

-(FILE *)shouldWriteFile
{
    NSDictionary *fileAttDic = [[WBCSandbox myFileManager] attributesOfItemAtPath:[self currentLogFilePath] error:nil];
    if(fileAttDic.fileSize > WBC_LOG_DEFAULT_SIZE_LIMIT)
    {
        if (lastModifyLogIndex == WBC_LOG_DEFAULT_COUNT_LIMIT) {
            lastModifyLogIndex = 1;
        }
        else{
            lastModifyLogIndex++;
        }
        return fopen([self.currentLogFilePath cStringUsingEncoding:NSUTF8StringEncoding], "w+");
    }
    else{
       return  fopen([self.currentLogFilePath cStringUsingEncoding:NSUTF8StringEncoding], "a+");
    }
}

-(NSString *)currentLogFilePath
{
    return [self.logPaths stringByAppendingPathComponent:[NSString stringWithFormat:@"log%@.log",@(lastModifyLogIndex)]];
}

-(void)logCrashLog:(NSString *)message
{
    [self logCrashReport2File:message];
}

-(BOOL)logCrashReport2File:(NSString *)log
{
    NSString *fileName =[NSString stringWithFormat:@"crash_%@.log",[self.carshDateFormatter stringFromDate:[NSDate date]]];
    NSString *path = [crashPaths stringByAppendingPathComponent:fileName];
    FILE *fd = fopen([path cStringUsingEncoding:NSUTF8StringEncoding],"w+");
    
    if (fd == NULL) {
        NSLog(@"open log file failed.");
        return NO;
    }
    
    fputs([log cStringUsingEncoding:NSUTF8StringEncoding], fd);
    fputs("\r\n", fd);
    fflush(fd);
    fclose(fd);
    
    return YES;
}

- (void)processException:(NSException *)exception
{
    NSDate *curDate = [NSDate date];
    NSString *exceptionInfo = [NSString stringWithFormat:@"DeviceName: %@\niOS:%f\nAppVersion:%@\ncurrent time: %@\nexception name: %@\nexception reason: %@\nexception userinfo: %@\n\nStack Trace: %@",
                               [[UIDevice currentDevice] model],
                               IOS_VERSION,
                               APP_VERSION,
                               [self.dateFormatter stringFromDate:curDate],
                               [exception name],
                               [exception reason],
                               [exception userInfo],
                               [exception callStackSymbols]
                               ];
    NSLog(@"processException:%@",exceptionInfo);
    [self logCrashLog:exceptionInfo];
}
@end

