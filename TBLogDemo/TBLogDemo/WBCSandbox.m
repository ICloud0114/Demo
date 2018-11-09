//
//  WBCSandbox.m
//  KuaiChong
//
//  Created by Onliu on 14-6-8.
//  Copyright (c) 2014年 Onliu. All rights reserved.
//

#import "WBCSandbox.h"

@implementation WBCSandbox
+(NSFileManager *)myFileManager
{
    static NSFileManager *_myFileManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _myFileManager = [[NSFileManager alloc] init];
    });
    return _myFileManager;
}

+ (NSString *)appPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)docPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libPrefPath
{
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/Preference"];

}

+ (NSString *)libCachePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/Caches"];
}

+ (NSString *)tmpPath
{
	return NSTemporaryDirectory();
}

+ (NSString *)touch:(NSString *)path
{
	if ( NO == [[[self class] myFileManager] fileExistsAtPath:path] )
	{
		[[[self class] myFileManager] createDirectoryAtPath:path
								  withIntermediateDirectories:YES
												   attributes:nil
														error:NULL];
	}
	return path;
}

+ (NSString *)findLastModifyFileInPath:(NSString *)path
{
    __block NSString *targetFilePath = nil;
    __block NSDate *lastDate = nil;
    [[[[self class] myFileManager] contentsOfDirectoryAtPath:path error:nil] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *fileAttributeDic = [[[self class] myFileManager] attributesOfItemAtPath:obj error:nil];
        if (lastDate == nil ||
            lastDate < fileAttributeDic.fileModificationDate) {
            lastDate = fileAttributeDic.fileModificationDate;
            targetFilePath = obj;
        }
    }];
    
    return targetFilePath;
}
@end
