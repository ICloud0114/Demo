//
//  UploadHeadPortraitCmd.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/25.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "UploadHeadPortraitCmd.h"

@implementation UploadHeadPortraitCmd

- (NSInteger)cmd {
    return TOPBAND_CMD_UHI;
}

- (NSDictionary *)payload {
    [sendValue setObject:self.headImageBase64String forKey:@"headImage"];
    [sendValue setObject:self.headImageBase64StringMd5 forKey:@"md5"];
    return sendValue;
}

@end
