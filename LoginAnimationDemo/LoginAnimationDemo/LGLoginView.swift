//
//  LGLoginView.swift
//  LoginAnimationDemo
//
//  Created by ICloud on 2018/8/23.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class LGLoginView: UIView {
    @IBOutlet weak var loginUserView: UIView!
    @IBOutlet weak var loginPasswordView: UIView!
    @IBOutlet weak var forgotView: UIView!
    @IBOutlet weak var submitView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func showAnimation(){
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            self.loginUserView.center = CGPoint(x: self.center.x, y:  25 + 25)
            self.loginUserView.layer.opacity = 1
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 1.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            
            self.loginPasswordView.center = CGPoint(x: self.center.x, y:  25 + 50 + 15 + 25)
            self.loginPasswordView.layer.opacity = 1
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 1.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            
            self.forgotView.center = CGPoint(x: self.forgotView.center.x, y:  25 + 50 + 15 + 50 + 15 + 25)
            self.forgotView.layer.opacity = 1
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 1.3, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            self.submitView.center = CGPoint(x: self.center.x, y:  25 + 50 + 15 + 50 + 75 + 25)
            self.submitView.layer.opacity = 1
        }) { _ in
            
        }
    }
    
    func hideAnimation() {
        UIView.animate(withDuration: 1, delay: 0.65, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            self.loginUserView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.loginUserView.frame.height / 2)
            self.loginUserView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0.45, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.loginPasswordView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.loginPasswordView.frame.height / 2)
            self.loginPasswordView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.forgotView.center = CGPoint(x: self.forgotView.center.x, y: self.bounds.height + self.forgotView.frame.height / 2)
            self.forgotView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.submitView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.submitView.frame.height / 2)
            self.submitView.layer.opacity = 0
        }) { _ in
            
        }
    }
}
