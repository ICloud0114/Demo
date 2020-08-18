//
//  InternalGlobalFunc.m
//  tSmartSDK
//
//  Created by Topband on 2017/11/9.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "InternalGlobalFunc.h"

NSString *asiiStringWithData(NSData *data) {
    if (data) {
        NSStringEncoding enc = NSASCIIStringEncoding;
        NSString *str =[[NSString alloc] initWithData:data encoding:enc];
        return str;
    }
    return nil;
}

NSData *stringAsciiData(NSString*hexString,int length) {
    int j=0;
    Byte bytes[length]; ///3ds key的Byte 数组， 128位
    for (int i = 0; i < [hexString length]; i++) {
        int int_ch; /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if (hex_char1 >= '0' && hex_char1 <='9')
            //int_ch1 = (hex_char1-48)*16; //// 0 的Ascll - 48
            int_ch1 = (hex_char1 - 48 + 0x00) << 4;
        else if (hex_char1 >= 'A' && hex_char1 <='F')
            //int_ch1 = (hex_char1-65)*16; //// A 的Ascll - 65
            int_ch1 = (hex_char1 - 65 + 0x0A) << 4;
        else
            //int_ch1 = (hex_char1-97)*16; //// a 的Ascll - 97
            int_ch1 = (hex_char1 - 97 + 0x0A) << 4;
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if (hex_char2 >= '0' && hex_char2 <='9')
            //int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
            int_ch2 = hex_char2 - 48 + 0x00;
        else if (hex_char2 >= 'A' && hex_char2 <='F')
            //int_ch2 = hex_char2-65; //// A 的Ascll - 65
            int_ch2 = hex_char2 - 65 + 0x0A;
        else
            //int_ch2 = hex_char2-97; //// a 的Ascll - 97
            int_ch2 = hex_char2 - 97 + 0x0A;
        
        //        int_ch = int_ch1+int_ch2;
        int_ch = int_ch1 | int_ch2;
        
        //DLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch; ///将转化后的数放入Byte数组里
        j++;
    }
    
    return [[NSData alloc] initWithBytes:bytes length:length];
    
}

NSString *convertDataToHexStr(NSData *data) {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

NSData *convertHexStrToData(NSString *str) {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

NSMutableData *stringToData(NSString*str ,int len) {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSMutableData *data = [NSMutableData data];
    if(str !=nil) {
        NSData *stringData = [str dataUsingEncoding:enc];
        
        if(len < stringData.length) { // 目标长度 len 小于字符串的实际长度，则只截取len长度的字符串
            
            [data setData:[stringData subdataWithRange:NSMakeRange(0, len)]];
        }else {
            [data setData: stringData];
        }
    }
    
    if(len > data.length) {// 字符串实际长度不够目标长度，则后面的字节补0，凑够len长度
        NSString *value = @"20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020";
        NSData *mData = stringAsciiData(value, 112);
        [data appendData:[mData subdataWithRange:NSMakeRange(0, len - data.length)]];
    }
    return data;
}
