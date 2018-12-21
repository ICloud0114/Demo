//
//  UploadHeadPortraitCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/25.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface UploadHeadPortraitCmd : TBBaseCmd

@property (nonatomic, copy) NSString *headImageBase64String; //头像base64编码
@property (nonatomic, copy) NSString *headImageBase64StringMd5;

@end
NS_ASSUME_NONNULL_END
