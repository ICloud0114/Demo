//
//  ViewController.swift
//  TBLogDemo
//
//  Created by ICloud on 2018/11/9.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        Log(message: "-------")
//        NSString* phoneModel = [[UIDevice currentDevice] model];
//
//        NSLog(@"手机型号: %@",phoneModel );
        let deviceMode = UIDevice.current.systemName
//        Log(message: deviceMode)
//        WBCLog.sharedInstance()
        Log_Info(msg: "-----")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

