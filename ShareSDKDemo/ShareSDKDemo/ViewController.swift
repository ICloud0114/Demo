//
//  ViewController.swift
//  ShareSDKDemo
//
//  Created by ICloud on 2018/9/27.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showShareSDKAction(_ sender: UIButton) {
//            TBUser.shareInstance().thirdLogin(withThirdId: <#T##String#>, thirdToken: <#T##String#>, type: <#T##Int32#>, completion: <#T##(Error?) -> Void#>)
        
        ShareSDK.getUserInfo(.typeWechat) { (state, user, error) in

        }
//        SSDKUser
//        ShareSDK.getUserInfo(.typeQQ) { (state, user, error) in
//
//        }
        
//        ShareSDK.getUserInfo(.typeSinaWeibo) { (state, user, error) in
//
//        }
    }
    

}

