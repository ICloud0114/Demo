//
//  TBChargingView.swift
//  Charging
//
//  Created by ICloud on 2018/5/18.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit
func Radians(_ degrees: CGFloat) -> CGFloat { return degrees * CGFloat(Double.pi) / 180.0 }
func Degrees(_ radians: CGFloat) -> CGFloat { return radians * 180.0 / CGFloat(Double.pi) }
class TBChargingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var energy: Int8 = 0
    
    var pointers = [UIImageView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for _ in 0 ..< 50 {
            let pointer = UIImageView(image: #imageLiteral(resourceName: "charging_blue"))
            self.addSubview(pointer)
            pointers.append(pointer)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for index in 0 ..< 50 {
            let pointer = pointers[index]
            pointer.frame = self.bounds
            if index > 0 {
                pointer.transform = CGAffineTransform(rotationAngle: Radians(7.2 * CGFloat(index)))
            }
        }
    }
    
    func chargingEnergy(_ count: UInt8 ) {
        let num = count / 2
        for index in 0 ..< 50 {
            let pointer = pointers[index]
            if index <= num{
                pointer.image = #imageLiteral(resourceName: "charging_blue")

            }else{
                pointer.image = #imageLiteral(resourceName: "charging_black")
            }
            starStatus(num == index, starLayer: pointer.layer)
        }
    }
    
    func starStatus(_ status: Bool, starLayer: CALayer) {
        if status {
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.duration = 2
            opacityAnimation.autoreverses = true
            opacityAnimation.fromValue = NSNumber(value: 1 as Float)
            opacityAnimation.toValue = NSNumber(value: 0.25 as Float)
            opacityAnimation.repeatCount = Float(INT_MAX)
            starLayer.add(opacityAnimation, forKey: "opacity animation")
        } else {
            starLayer.removeAnimation(forKey: "opacity animation")
        }
    }
}
