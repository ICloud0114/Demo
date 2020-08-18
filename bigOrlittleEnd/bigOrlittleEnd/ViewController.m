//
//  ViewController.m
//  bigOrlittleEnd
//
//  Created by ICloud on 2019/3/15.
//  Copyright © 2019 ICloud. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    int x = 0x12345678;
    char* px = (char*)&x;
    printf("%x%x%x%x\n", px[0], px[1], px[2], px[3]);
    
    BOOL result = checkCPU();
    printf("%d",result);
    
}
int checkCPU()
{
    union w
    {
        int a;//在ios中，4 Byte
        char b;//在ios中，1 Byte
    } c;
    c.a = 1;
    return(c.b ==1);//如果c.b == 1，表示第一位是0x01，那就是小端，如果返回0，就是大端
}

@end
