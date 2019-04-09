//
//  ViewController.swift
//  AttributeStringDemo
//
//  Created by ICloud on 2019/1/2.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let text = "删除后该用户将失去该门锁的使用权限，确定删除？\n 注：为了您的用锁安全，请尽快使用密码进行一次开门操作！"
        let attText = NSMutableAttributedString(string: text)
        
        let range1 = NSRange(location: 0, length: 23)
        let range2 = NSRange(location: 24, length: 28)
        let attribute1 = [NSAttributedString.Key.foregroundColor : UIColor.black,
                          NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        let attribute2 = [NSAttributedString.Key.foregroundColor: UIColor.red,
                          NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)]
        attText.addAttributes(attribute1, range: range1)
        attText.addAttributes(attribute2, range: range2)
        messageLabel.attributedText = attText
    }


}

