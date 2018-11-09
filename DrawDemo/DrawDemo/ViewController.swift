//
//  ViewController.swift
//  DrawDemo
//
//  Created by ICloud on 2018/11/3.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let orign = [(54, 679), (603, 677), (602, 705), (54, 706), (52, 735), (603, 732), (54, 734), (53, 765),(58, 760), (58, 770), (213, 770), (59, 770), (57, 684), (617, 686), (616, 655), (55, 653),(626, 625), (627, 595), (51, 593), (51, 563), (613, 565), (613, 536), (47, 535), (49, 506),(621, 476), (44, 477), (44, 447), (235, 448), (235, 417), (196, 405), (38, 404), (39, 376),(220, 345), (34, 343), (36, 314), (239, 315), (238, 278), (31, 278), (32, 248), (212, 247),(26, 210), (27, 180), (590, 180), (591, 150), (8, 152), (10, 122), (589, 123), (591, 93),(19, 65), (542, 71), (544, 35), (22, 35), (22, 5)]
        
        let result = orign.map({
            sub in
            return (Double(sub.0) * 0.5, (Double(386) - Double(sub.1) * 0.5))
        })
        print(result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

