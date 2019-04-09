//
//  ViewController.swift
//  MessageDemo
//
//  Created by ICloud on 2018/12/27.
//  Copyright © 2018 ICloud. All rights reserved.
//

import UIKit
import MessageUI
class ViewController: UIViewController, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate{
//class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func showMessage(){
        //设置联系人
        if MFMessageComposeViewController.canSendText() {

            let controller = MFMessageComposeViewController()
            //短信的内容,可以不设置
            controller.body = "-------lalal "/*"""
             您好，您的密码是：1234 567

             生效时间：2017-12-09 08:00

             类型：单次

             锁名：客厅门锁

             密码需要在2017-12-09 16:00前使用，否则将失效。

             输入密码后，按锁键盘右下角开锁键或#键结束。
             """*/
            //            controller.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.hexColor("0xffad5b")]
            //            controller.navigationBar.tintColor = UIColor.blue
            //            controller.navBarBGAlpha = 1
            //            controller.navBarTintColor = UIColor.blue

            //联系人列表
            controller.recipients = ["---"]
            //设置代理
            controller.messageComposeDelegate = self

            self.present(controller, animated: true, completion: nil)
        } else {
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        //判断短信的状态
        switch result{
        case .sent:
            NSLog("短信已发送")
        case .cancelled:
            NSLog("短信取消发送")
        case .failed:
            NSLog("短信发送失败")
        }

    }
}

