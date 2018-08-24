//
//  roundStackView.swift
//  RoundedViewDemo
//
//  Created by ICloud on 2018/8/16.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class roundStackView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override open func draw(_ rect: CGRect) {
        // Drawing code
        let bzpath = UIBezierPath()
        
        drawRoundRect(bzpath, rect)
        UIColor.black.setStroke()
        
        bzpath.lineWidth = 1
        
        bzpath.stroke()
        let shap = CAShapeLayer(layer: layer)
        shap.path = bzpath.cgPath
        layer.mask = shap
    }
    
    func drawRoundRect(_ bz: UIBezierPath, _ rect: CGRect) {
        let cornerTopLeft: CGFloat = 10.0
        let cornerTopRight: CGFloat = 10.0
        let cornerBottomLeft: CGFloat = 10.0
        let cornerBottomRight: CGFloat = 10.0
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
