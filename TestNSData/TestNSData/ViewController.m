//
//  ViewController.m
//  TestNSData
//
//  Created by ICloud on 2020/5/25.
//  Copyright © 2020 ICloud. All rights reserved.
//
#import "InternalGlobalFunc.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *hexString = @"aa01010114";
    NSData *data = convertHexStrToData(hexString);
    
    Byte *testByte = [data bytes];

    for (int i = 0; i < data.length; i++) {
        NSLog(@"%x",testByte[i]);
        NSLog(@"%hhu",testByte[i]);
    }
    
    
    NSString *str = convertDataToHexStr(data);
    NSLog(@"%@", str);

}


@end
