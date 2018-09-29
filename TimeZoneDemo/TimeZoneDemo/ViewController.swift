//
//  ViewController.swift
//  TimeZoneDemo
//
//  Created by ICloud on 2018/9/25.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var systemTime: UILabel!
    @IBOutlet weak var egTime: UILabel!
    
    @IBOutlet weak var gmt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        systemTime.text = formatter1.string(from: Date())
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        gmt.text = formatter.string(from: Date())
        
        
        let formatter2: DateFormatter = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let zone = TimeZone(secondsFromGMT: 28800)
//        let zone = TimeZone(abbreviation: "UTC+0800")
        formatter2.timeZone = zone
        
        egTime.text = formatter2.string(from: Date())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

