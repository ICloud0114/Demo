//
//  ViewController.swift
//  NumberAnimationDemo
//
//  Created by ICloud on 2018/10/29.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var number1: AnimationLabel!
    
    @IBOutlet weak var number2: AnimationLabel!
    
    @IBOutlet weak var number3: AnimationLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        number1.count(from: 0, to: 3600)
        number2.count(from: 0, to: 80)
        number3.count(from: 0, to: 1200)
    }

    @IBAction func addAction(_ sender: Any) {
        
        number1.countFromCurrent(to: Float(number1.text!)! + 220)
        number2.countFromCurrent(to: Float(number2.text!)! + 3)
        number3.countFromCurrent(to: Float(number3.text!)! + 100)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

