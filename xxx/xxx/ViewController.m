//
//  ViewController.m
//  xxx
//
//  Created by ICloud on 2018/7/24.
//  Copyright © 2018年 ICloud. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectContactAction:(id)sender {
    
    CNContactPickerViewController * picker = [CNContactPickerViewController new];
    // 2. 设置代理
    picker.delegate = self;
    // 3. 设置相关属性，谓词筛选email地址是@mac.com的联系人
//    picker.predicateForSelectionOfProperty = [NSPredicate predicateWithFormat:@"(key == 'emailAddresses') AND (value LIKE '*@mac.com')"];
//    picker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count == 1"];
    // 4. 弹出
    [self presentViewController: picker  animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    for (CNLabeledValue *labeledValue in contact.phoneNumbers) {
        NSLog(@"label: %@",labeledValue.label);
        CNPhoneNumber *phoneNumber = labeledValue.value;
        NSLog(@"phoneNumber: %@",phoneNumber.stringValue);
    }
   
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}

@end
