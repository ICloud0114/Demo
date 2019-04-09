//
//  ViewController.m
//  testFramwork
//
//  Created by ICloud on 2018/12/11.
//  Copyright © 2018年 ICloud. All rights reserved.
//

#import "ViewController.h"

#import <TBUser_Http_Lib/TBUser.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (IBAction)loginAction:(id)sender {
    [[TBUser shareInstance] loginWithAccount:@"18565772859" password:@"123456" completion:^(NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"-----登录失败");
        }
        NSLog(@"-----登录成功");
    }];
}
- (IBAction)requestCodeAction:(id)sender {
    [TBUser generatorCodeWithAccount:@"18576692579" loginType:3 codeType:0 completion:^(NSError * _Nullable error) {
        
    }];
}
- (IBAction)registerAction:(id)sender {
    [TBUser registerWithAccount:@"18576692579" password:@"123456" code:self.codeTextField.text completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

@end
