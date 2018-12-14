//
//  ViewController.m
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "ViewController.h"
#import <Topband_Cloud_TBUser/TBUser.h>
#import "TBPowerStationManager.h"
#import "TBPowerStation+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)loginAction {
    [[TBUser shareInstance] loginWithAccount:@"110@qq.com" password:@"123456" completion:^(TBResponse * _Nonnull response) {
        
    }];
}

- (IBAction)getPowerStationList:(id)sender {
    NSArray *list = [[TBPowerStationManager share] powerStations];
    NSLog(@"%@", list);
    TBPowerStation *station = list[0];
    NSArray *devices = [station powerStationDevices];
    NSLog(@"%@", devices);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
