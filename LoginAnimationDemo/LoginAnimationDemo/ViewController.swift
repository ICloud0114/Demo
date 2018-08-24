//
//  ViewController.swift
//  LoginAnimationDemo
//
//  Created by ICloud on 2018/8/23.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoView: UIView!
    @IBOutlet weak var loginView: LGLoginView!
    
    @IBOutlet weak var registerView: RGRegisterView!
    
    
    
    var animator: UIDynamicAnimator!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animator = UIDynamicAnimator(referenceView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func showLoginView(_ sender: Any) {
        
        registerView.hideAnimation()
        UIView.animate(withDuration: 0.618, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            self.registerView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height + self.registerView.frame.height / 2)
            self.registerView.layer.opacity = 0
        }) { _ in

        }

        UIView.animate(withDuration: 0.382, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height - self.loginView.frame.height / 2)
            self.loginView.layer.opacity = 1
        }) { _ in

        }
        loginView.showAnimation()
        
    }
    @IBAction func showRegisterViewAction(_ sender: Any) {
        
        loginView.hideAnimation()
        UIView.animate(withDuration: 0.618, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height + self.loginView.frame.height / 2)
            self.loginView.layer.opacity = 0
        }) { _ in

        }

        UIView.animate(withDuration: 0.382, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            self.registerView.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height - self.registerView.frame.height / 2)
            self.registerView.layer.opacity = 1
        }) { _ in

        }
        registerView.showAnimation()
        
    }
    
}

extension UIViewController: CAAnimationDelegate{
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
//        let layer                  = anim.value(forKey: "layer")
//        anim.setValue(nil, forKey: "layer")
//
//        //脉冲动画
//        let  pulseAnimation   = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
//        pulseAnimation.damping             = 7.5;
//        pulseAnimation.fromValue           = @(1.25);
//        pulseAnimation.toValue             = @(1.);
//        pulseAnimation.duration            = pulseAnimation.settlingDuration;
//        [layer addAnimation:pulseAnimation forKey:nil];
        
    }
}

