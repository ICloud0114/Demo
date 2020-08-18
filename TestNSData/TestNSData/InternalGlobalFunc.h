//
//  InternalGlobalFunc.h
//  tSmartSDK
//
//  Created by Topband on 2017/11/9.
//  Copyright © 2017年 topband. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *asiiStringWithData(NSData *data);

NSData *stringAsciiData(NSString*hexString,int length);

NSMutableData *stringToData(NSString*str ,int len);

NSString *convertDataToHexStr(NSData *data);

NSData *convertHexStrToData(NSString *str);

