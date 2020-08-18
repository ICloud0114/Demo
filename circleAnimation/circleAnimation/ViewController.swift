//
//  ViewController.swift
//  circleAnimation
//
//  Created by ICloud on 2019/7/10.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cycle1: UIImageView!
    @IBOutlet weak var cycle2: UIImageView!
    @IBOutlet weak var cycle3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rorateAnimation(holdView: cycle1, duration: 7)
        rorateAnimation(holdView: cycle2, duration: 3)
        rorateAnimation(holdView: cycle3, duration: 5)
        opacityAnimation(holdView: cycle2, duration: 2)
        opacityAnimation(holdView: cycle3, duration: 3)
        scaleAnimation(holdView: cycle2, duration: 2)
        scaleAnimation(holdView: cycle3, duration: 2)
    }
    
    func opacityAnimation(holdView: UIView, duration: CFTimeInterval){
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.autoreverses = true
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.3
        opacityAnimation.repeatCount = Float(INT_MAX)
        holdView.layer.add(opacityAnimation, forKey: "opacityAnimation")
    }
    
    func scaleAnimation(holdView: UIView, duration: CFTimeInterval){
       let animation  = CABasicAnimation(keyPath: "transform.scale")
    
        animation.duration = duration
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        animation.fromValue = 1.0
        animation.toValue = 0.95
        
        holdView.layer.add(animation, forKey: "scaleAnimation")
    }
    
    func rorateAnimation(holdView: UIView, duration: CFTimeInterval){
        
        let momAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        momAnimation.fromValue = NSNumber(value: 0)
        momAnimation.toValue = NSNumber(value: double_t.pi * 2)
        momAnimation.duration = duration
        momAnimation.repeatCount = HUGE
        holdView.layer.add(momAnimation, forKey: "centerLayer")
    }

}

