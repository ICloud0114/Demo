//
//  ViewController.swift
//  ICProgressViewDemo
//
//  Created by ICloud on 2018/8/30.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
@IBOutlet weak var progressView: ICProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressView.progressTint = UIColor.hexColor("0x0be5ba")
        progressView.trackTint = UIColor.hexColor("0xf3f3f3")
        progressView.flat = false
        progressView.animate = true
        
        progressView.showText = true
        progressView.showStroke = false
        progressView.showTrack = true
        progressView.showTrackInnerShadow = false
        
        progressView.progress = 0.8
        
        progressView.outerStrokeWidth = 0
        progressView.progressInset = 0
        progressView.borderRadius = 10
        progressView.style = .Stripe
    }
    @IBAction func sliderChangeAction(_ sender: UISlider) {
        progressView.progress = sender.value
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

