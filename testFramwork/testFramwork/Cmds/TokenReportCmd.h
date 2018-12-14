//
//  TokenReportCmd.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/21.
//  Copyright © 2017年 topband. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN
@interface TokenReportCmd : TBBaseCmd

@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *os;
@property (nonatomic, copy) NSString *phoneToken;

@end
NS_ASSUME_NONNULL_END
