//
//  ViewController.swift
//  TestDemo
//
//  Created by ICloud on 2018/11/14.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        for _ in 0 ... 100000 {
//            Log_Info(msg: "---->info")
//        }
    }

    @IBAction func addLogAction(_ sender: Any) {
        Log_Debug(msg: "-----debug")
        
        Log_Debug(msg: "-----debug")

    }
    
}

