//
//  RGRegisterView.swift
//  LoginAnimationDemo
//
//  Created by ICloud on 2018/8/23.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class RGRegisterView: UIView {

    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var passwordView: UIView!
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
            
            self.userView.center = CGPoint(x: self.center.x, y:25 + 25)
            self.userView.layer.opacity = 1
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 1.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            
            self.codeView.center = CGPoint(x: self.center.x, y: 25 + 50 + 15 + 25)
            self.codeView.layer.opacity = 1
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 1.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            
            
            self.passwordView.center = CGPoint(x: self.center.x, y: 25 + 50 + 15 + 50 + 15 + 25)
            self.passwordView.layer.opacity = 1
            
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
            self.userView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.userView.frame.height / 2)
            self.userView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0.45, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.codeView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.codeView.frame.height / 2)
            self.codeView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.passwordView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.passwordView.frame.height / 2)
            self.passwordView.layer.opacity = 0
            
        }) { _ in
            
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.submitView.center = CGPoint(x: self.center.x, y: self.bounds.height + self.submitView.frame.height / 2)
            self.submitView.layer.opacity = 0
        }) { _ in
            
        }
    }
}
