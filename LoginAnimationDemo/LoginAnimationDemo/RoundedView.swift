//
//  RoundedView.swift
//  RoundedViewDemo
//
//  Created by ICloud on 2018/8/16.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit


extension UIView{
    func drawRoundRect(_ tl: CGFloat, _ tr: CGFloat, _ bl: CGFloat, _ br: CGFloat) {
        
        let bzpath = UIBezierPath()
        bzpath.move(to: CGPoint(x: 0, y: tl))
        bzpath.addQuadCurve(to: CGPoint(x: tl, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        
        bzpath.addLine(to: CGPoint(x: self.frame.width - tr, y: 0))
        
        bzpath.addQuadCurve(to: CGPoint(x: self.frame.width, y: tr), controlPoint: CGPoint(x: self.frame.width, y: 0))
        
        bzpath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height - br))
        
        bzpath.addQuadCurve(to: CGPoint(x: self.frame.width - br, y: self.frame.height), controlPoint: CGPoint(x: self.frame.width, y: self.frame.height))
        
        bzpath.addLine(to: CGPoint(x: bl, y: self.frame.height))
        
        bzpath.addQuadCurve(to: CGPoint(x: 0, y: self.frame.height - bl), controlPoint: CGPoint(x: 0, y: self.frame.height))
        
        bzpath.close()

        let shap = CAShapeLayer(layer: layer)
        
        shap.path = bzpath.cgPath
        shap.borderWidth = 1
        shap.borderColor = UIColor.red.cgColor
        layer.mask = shap

    }
    
}

@IBDesignable open class RoundedView: UIView {
    
    @IBInspectable dynamic open var cornerRadius: CGFloat = 0 {
        didSet {
            
        }
    }
    
    @IBInspectable dynamic open var cornerTopLeft: CGFloat = 0 {
        didSet {
            
        }
    }
    @IBInspectable dynamic open var cornerTopRight: CGFloat = 0 {
        didSet {

        }
    }
    @IBInspectable dynamic open var cornerBottomLeft: CGFloat = 0 {
        didSet {

        }
    }
    @IBInspectable dynamic open var cornerBottomRight: CGFloat = 0 {
        didSet {

        }
    }

    @IBInspectable dynamic open var borderWidth: CGFloat = 1 {
        didSet {
            
        }
    }
    
    @IBInspectable dynamic open var borderColor: UIColor = .black {
        didSet {
            
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        var bzpath = UIBezierPath()
        
        if cornerRadius == 0{
            drawRoundRect(bzpath, rect)
        }else{
            bzpath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        }
        borderColor.setStroke()
        bzpath.lineWidth = borderWidth

        bzpath.stroke()
        let shap = CAShapeLayer(layer: layer)
        shap.path = bzpath.cgPath
        layer.mask = shap
    }
    
    func drawRoundRect(_ bz: UIBezierPath, _ rect: CGRect) {
        bz.move(to: CGPoint(x: 0, y: cornerTopLeft))
        
        bz.addQuadCurve(to: CGPoint(x: cornerTopLeft, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        
        bz.addLine(to: CGPoint(x: rect.width - cornerTopRight, y: 0))
        
        bz.addQuadCurve(to: CGPoint(x: rect.width, y: cornerTopRight), controlPoint: CGPoint(x: rect.width, y: 0))
        
        bz.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerBottomRight))
        
        bz.addQuadCurve(to: CGPoint(x: rect.width - cornerBottomRight, y: rect.height), controlPoint: CGPoint(x: rect.width, y: rect.height))
        
        bz.addLine(to: CGPoint(x: cornerBottomLeft, y: rect.height))
        
        bz.addQuadCurve(to: CGPoint(x: 0, y: rect.height - cornerBottomLeft), controlPoint: CGPoint(x: 0, y: rect.height))
        
        bz.close()
    }

}
