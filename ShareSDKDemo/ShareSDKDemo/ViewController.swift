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
    
    @IBAction func weChatLoginAction(_ sender: Any){
        if ShareSDK.hasAuthorized(.typeWechat){
            ShareSDK.cancelAuthorize(.typeWechat)
        }
        
        ShareSDK.getUserInfo(.typeWechat) { (state, user, error) in
            
        }
    }
    
    @IBAction func qqLoginAction(_ sender: Any){
        if ShareSDK.hasAuthorized(.typeQQ){
            ShareSDK.cancelAuthorize(.typeQQ)
        }
        
        ShareSDK.getUserInfo(.typeQQ) { (state, user, error) in
            
        }
    }
    
    @IBAction func weiboLoginAction(_ sender: Any){
        ShareSDK.getUserInfo(.typeSinaWeibo) { (state, user, error) in
            
        }
    }
    
    @IBAction func shareWechatAction(_ sender: Any) {
        
        let params = NSMutableDictionary()
        params.ssdkSetupShareParams(byText: "-----", images: UIImage(named: "lucky"), url: nil, title: nil, type: .image)
        ShareSDK.share(.subTypeWechatSession, parameters: params) { (state, data, content, error) in
            
        }
    }
    
    @IBAction func shareMomentsAction(_ sender: Any) {
        let params = NSMutableDictionary()
        params.ssdkSetupShareParams(byText: "-----", images: UIImage(named: "lucky"), url: nil, title: nil, type: .image)
        ShareSDK.share(.subTypeWechatTimeline, parameters: params) { (state, data, content, error) in
            
        }

    }
    @IBAction func shareWeiboAction(_ sender: Any) {
        
        let params = NSMutableDictionary()
        params.ssdkSetupShareParams(byText: "-----", images: UIImage(named: "lucky"), url: nil, title: nil, type: .image)
        ShareSDK.share(.typeSinaWeibo, parameters: params) { (state, data, content, error) in
            
        }
    }
    
    
    
}

