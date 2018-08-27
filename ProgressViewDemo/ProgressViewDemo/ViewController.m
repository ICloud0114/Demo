//
//  ViewController.m
//  ProgressViewDemo
//
//  Created by ICloud on 2018/8/27.
//  Copyright © 2018年 ICloud. All rights reserved.
//

#import "ViewController.h"
#import "LDProgressView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet LDProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _progressView.color = [UIColor colorWithRed:11.f/255.f green:229.f/255.f blue:186.f/255.f alpha:1.0f];
    _progressView.background = [UIColor colorWithRed:243.f/255.f green:243.f/255.f blue:243.f/255.f alpha:1.0];
    _progressView.flat = @NO;
    _progressView.showText = @NO;
    _progressView.type = LDProgressStripes;
    _progressView.showBackgroundInnerShadow = @NO;
    _progressView.progress = 0.8;
    _progressView.animate = @YES;

    [self.view addSubview:_progressView];
}

- (IBAction)sliderValueAction:(UISlider *)sender {
    _progressView.progress = sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
