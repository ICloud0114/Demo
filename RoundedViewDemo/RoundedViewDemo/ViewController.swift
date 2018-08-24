//
//  ViewController.swift
//  RoundedViewDemo
//
//  Created by ICloud on 2018/8/16.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sView: UIView!
    
    @IBOutlet weak var rView: UIView!
    @IBOutlet weak var roundedView: RoundedView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view.layoutIfNeeded()
        
//        roundedView.drawRoundRect(10, 10, 0, 0)
//        stackView.drawRoundRect(10, 10, 10, 10)
//        sView.drawRoundRect(10, 10, 10, 10)
        titleLabel.drawRoundRect(100, 100, 100, 100)
//        rView.layer.cornerRadius = 10

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

