//
//  ViewController.m
//  TestRunningTime
//
//  Created by ICloud on 2018/12/26.
//  Copyright © 2018 ICloud. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *nullValue = [NSNull null];
    [nullValue removeAllObjects];
    NSLog(nullValue);
}


@end
