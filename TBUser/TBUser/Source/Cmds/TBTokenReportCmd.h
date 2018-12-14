//
//  TBTokenReportCmd.h
//  TBUser
//
//  Created by Topband on 2018/4/9.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import <tSmartSDK/tSmartSDK.h>

@interface TBTokenReportCmd : TBBaseCmd

@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *os;
@property (nonatomic, copy) NSString *phoneToken;

@end
