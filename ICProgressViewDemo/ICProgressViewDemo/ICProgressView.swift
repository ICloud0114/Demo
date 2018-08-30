//
//  ICProgressView.swift
//  ProgressViewDemo
//
//  Created by ICloud on 2018/8/29.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICProgressView: UIView {

    enum ICProgressStyle {
        case Default //纯色
        case Stripe  //条纹
        case Gradient //渐变
    }
    //  进度条风格
    var style: ICProgressStyle = .Default
    //  进度
    var progress: Float = 0.5{
        didSet{
            self.progressToAnimateTo = progress
            if self.animate {
                if self.animationTimer != nil {
                    self.animationTimer?.invalidate()
                }
                self.animationTimer = Timer.scheduledTimer(withTimeInterval: 0.008, repeats: true, block: { (_) in
                    self.incrementAnimatingProgress()
                })
            } else {
                self.setNeedsDisplay()
            }
        }
    }
    //  进度条颜色
    var progressTint: UIColor = UIColor.red
    //  轨道颜色
    var trackTint: UIColor = UIColor.black
    //  动画
    var animate: Bool = true{
        willSet{
            if newValue {
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (_) in
                    self.incrementOffset()
                })
            } else if self.timer != nil {
                self.timer?.invalidate()
            }
        }
    }
    // 平面的 - NO: 立体效果
    var flat: Bool = false
    //  圆角
    var borderRadius: CGFloat = 0
    //  显示进度轮廓
    var showStroke: Bool = true
    //  显示进度文字
    var showText: Bool = true
    //  显示轨道
    var showTrack: Bool = true
    //  显示轨道内阴影
    var showTrackInnerShadow = true
    //  外轮廓宽度
    var outerStrokeWidth: CGFloat = 0
    //  进度偏移
    var progressInset: CGFloat = 0
    
    fileprivate var timer: Timer?
    
    fileprivate var offset: CGFloat = 0
    
    fileprivate lazy var stripeWidth: CGFloat = {
        if self.style == .Stripe{
            return self.frame.height * 2;
        }
        return self.frame.width
    }()
    
    fileprivate var progressToAnimateTo: Float?
    
    fileprivate var animationTimer: Timer?
    
    fileprivate var progressTextOverride: String?
    
    fileprivate lazy var gradientProgress: UIImage = {
        
        UIGraphicsBeginImageContext(CGSize(width: self.stripeWidth, height: self.frame.height))
        
        let imageCxt = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations = [CGFloat(0.0), CGFloat(0.5), CGFloat(1.0)]
        let colors = [UIColor.clear.cgColor, self.progressTint.darkerColor().withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        
        imageCxt?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: self.frame.height / 2), end: CGPoint(x: self.stripeWidth, y: self.frame.height / 2), options: [])

//        CGGradientRelease(gradient);
//        CGColorSpaceRelease(colorSpace);
        let gp = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gp!
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize() {
        self.backgroundColor = .clear
    }
    
    func incrementAnimatingProgress(){
        if progress >= self.progressToAnimateTo! - 0.01 && progress < self.progressToAnimateTo! + 0.01{
            progress = self.progressToAnimateTo!
            self.animationTimer?.invalidate()
            self.setNeedsDisplay()
        }else{
            progress = (progress < self.progressToAnimateTo!) ? progress + 0.01 : progress - 0.01
            self.setNeedsDisplay()
        }
    }
    
    func incrementOffset() {
        if self.offset - 0.0 >= 0.0{
            self.offset = -self.stripeWidth
        }else{
            self.offset += 1
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        if self.showTrack{
            drawTrack(context: context!, in: rect)
        }
        
        if self.outerStrokeWidth != 0{
            drawOuterStroke(context: context!, rect: rect)
        }
        
        if (self.progress > 0) {
            drawProgress(context: context!, frame: self.progressInset != 0 ? rect.insetBy(dx: self.progressInset, dy: self.progressInset) : rect)
        }
    }
    
//    //背景
    
    func drawTrack(context: CGContext, in rect: CGRect)  {

        context.saveGState()
        
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: self.borderRadius)
        context.setFillColor(self.trackTint.cgColor)
        roundedRect.fill()

        
        let roundedRectAngleNegativePath = UIBezierPath(rect: CGRect(x: -10, y: -10, width: rect.width + 10, height: rect.height + 10))
        
        roundedRectAngleNegativePath.append(roundedRect)
        roundedRectAngleNegativePath.usesEvenOddFillRule = true

        if showTrackInnerShadow {
        let shadowOffset = CGSize(width: 0.5, height: 1)
        context.saveGState()
        
        let xOffset = shadowOffset.width + round(rect.size.width)
        let yOffset = shadowOffset.height
            
        context.setShadow(offset: CGSize(width: (xOffset + copysign(0.1, xOffset)), height: (yOffset + copysign(0.1, yOffset))), blur: 5, color: UIColor.black.withAlphaComponent(0.7).cgColor)
        }
        roundedRect.addClip()
        
        let transform = CGAffineTransform(translationX: -round(rect.size.width), y: 0)
        roundedRectAngleNegativePath.apply(transform)
        UIColor.gray.setFill()
        roundedRectAngleNegativePath.fill()
        
        context.restoreGState()

        // Add clip for drawing progress
        roundedRect.addClip()
    }

    func drawOuterStroke(context: CGContext, rect: CGRect){
        let bezierPath = UIBezierPath(roundedRect: rect.insetBy(dx: outerStrokeWidth / 2, dy: outerStrokeWidth / 2), cornerRadius: self.borderRadius)
        self.progressTint.setStroke()
        bezierPath.lineWidth = outerStrokeWidth
        bezierPath.stroke()
    }
    
    func drawProgress(context: CGContext, frame: CGRect){
        let rectToDrawIn = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width * CGFloat(self.progress), height: frame.height)
        var insetRect = rectToDrawIn.insetBy(dx: CGFloat(self.progress) > 0.03 ? 0.5 : -0.5, dy: 0.5)
        if !self.showText{
            insetRect = rectToDrawIn
        }
        
        let roundedRect = UIBezierPath(roundedRect: insetRect, cornerRadius: self.borderRadius)
        if self.flat{
            context.setFillColor(self.progressTint.cgColor)
            roundedRect.fill()
        }else{
           context.saveGState()
            roundedRect.addClip()
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let locations = [CGFloat(0.0), CGFloat(1.0)]
            let colors = [self.progressTint.lighterColor().cgColor, self.progressTint.darkerColor().cgColor]
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
            context.drawLinearGradient(gradient!, start: CGPoint(x: insetRect.width / 2, y: 0), end: CGPoint(x: insetRect.width / 2, y: insetRect.height), options: [])
            context.restoreGState()
            //    CGGradientRelease(gradient);
            //    CGColorSpaceRelease(colorSpace);
        }
        if self.progress != 1{
            switch self.style{
            case .Stripe:
                drawStripes(context, rect: insetRect)
            case .Default:
                drawGradients(context, rect: insetRect)
            case .Gradient:
                break
            }
        }
        if self.showStroke{
            context.setStrokeColor(self.progressTint.darkerColor().cgColor)
            roundedRect.stroke()
        }
    
        if self.showText {
            drawRightAlignedLabel(rect: insetRect)
        }
    }
    
    func drawGradients(_ context: CGContext, rect: CGRect) {
//        let stripeSize = CGSize(width: self.stripeWidth, height: rect.height)
        context.saveGState()
        UIBezierPath(roundedRect: rect, cornerRadius: self.borderRadius).addClip()
        var xStart = self.offset
        while xStart < rect.size.width {
            self.gradientProgress.draw(at: CGPoint(x: xStart, y: 0))
            xStart += self.stripeWidth
        }
        context.restoreGState()
    }
    
    func drawStripes(_ context: CGContext, rect: CGRect){
        context.saveGState()
        UIBezierPath(roundedRect: rect, cornerRadius: self.borderRadius).addClip()
        context.setFillColor(UIColor.white.withAlphaComponent(0.5).cgColor)
        var xStart = self.offset
        let height = rect.height
        let width = self.stripeWidth
        let y = rect.origin.y
        while xStart < rect.width {
            context.saveGState()
            context.move(to: CGPoint(x: xStart, y: height + y))
            context.addLine(to: CGPoint(x: xStart + width * 0.25, y: 0))
            context.addLine(to: CGPoint(x: xStart + width * 0.75, y: 0))
            context.addLine(to: CGPoint(x: xStart + width * 0.5, y: height + y))
            context.closePath()
            context.fillPath()
            context.restoreGState()
            xStart += width
        }
        context.restoreGState()
    }
    
    func drawRightAlignedLabel(rect: CGRect){
        if rect.size.width > 40{
            let label = UILabel(frame: rect)
            label.adjustsFontSizeToFitWidth = true
            label.backgroundColor = UIColor.clear
            label.textAlignment = NSTextAlignment.right
            label.text = self.progressTextOverride != nil ? self.progressTextOverride : String(format: "%02d%%", Int(self.progress * 100))
            label.font = UIFont.boldSystemFont(ofSize: 17 - self.progressInset * 1.75)
            let baseLabelColor = self.progressTint.isLighterColor() ? UIColor.black : UIColor.white
            label.textColor = baseLabelColor.withAlphaComponent(0.6)
            label.drawText(in: CGRect(x: rect.origin.x + 6, y: rect.origin.y, width: rect.size.width - 12, height: rect.size.height))
        }
    }
}
