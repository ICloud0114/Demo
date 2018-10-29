//
//  loadingView.swift
//  CircleLoadingDemo
//
//  Created by ICloud on 2018/10/29.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class loadingView: UIView {

    var containerLayer: CAReplicatorLayer!
    
    var animationDuration = 0.95
    var circleContainerSize: CGFloat = 60
    var circleCount = 8
    var circleSize: CGFloat = 15
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = UIColor.gray
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        containerLayer.frame = CGRect(x: (frame.width - circleContainerSize) / 2.0, y: (frame.height - circleContainerSize) / 2.0, width: circleContainerSize, height: circleContainerSize)
    }
    
    func setup() {
        containerLayer = CAReplicatorLayer()
        containerLayer.frame = CGRect(x: (frame.width - circleContainerSize) / 2.0, y: (frame.height - circleContainerSize) / 2.0, width: circleContainerSize, height: circleContainerSize)
        containerLayer?.masksToBounds = true
        containerLayer?.instanceCount = circleCount
        containerLayer?.instanceDelay = animationDuration / Double(circleCount)
        let angle = CGFloat(360 * Double.pi / Double(180)) / CGFloat(circleCount)
        containerLayer?.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        self.layer.addSublayer(containerLayer)
    }
    
    func beginAnimation() {
        let subLayer = CALayer()
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.frame = CGRect(x: (circleContainerSize - circleSize) / 2.0, y: 0, width: circleSize, height: circleSize)
        subLayer.cornerRadius = circleSize / 2.0
        subLayer.transform = CATransform3DMakeScale(0, 0, 0)
        containerLayer.addSublayer(subLayer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.repeatCount = HUGE
        animation.duration = animationDuration
        subLayer.add(animation, forKey: nil)
    }
}
