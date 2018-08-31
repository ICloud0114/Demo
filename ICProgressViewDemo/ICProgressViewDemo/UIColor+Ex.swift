//
//  UIColor+Ex.swift
//  ContactsDemo
//
//  Created by ICloud on 2018/8/30.
//  Copyright © 2018年 ICloud. All rights reserved.
//
import UIKit

extension UIColor{

    class func hexColor(_ hexString: String) -> UIColor {
        return hexColor(hexString, alpha: 1.0)
    }
    
    class func hexColor(_ hexString: String, alpha: CGFloat) -> UIColor {
        var str = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (str.characters.count < 6) {
            return UIColor.clear
        }
        
        if (str.hasPrefix("0X")) {
            str = String(str[str.characters.index(str.startIndex, offsetBy: 2)...])//str.substring(from: str.characters.index(str.startIndex, offsetBy: 2))
        }
        if (str.hasPrefix("#")) {
            str = String(str[str.characters.index(str.startIndex, offsetBy: 1)...])//str = str.substring(from: str.characters.index(str.startIndex, offsetBy: 1))
        }
        if (str.characters.count != 6) {
            return UIColor.clear
        }
        
        //Separate into r, g, b substrings
        //r
        let rStr = String(str[Range(str.startIndex ..< str.characters.index(str.startIndex, offsetBy: 2))])
        //g
        let gStr = String(str[Range(str.characters.index(str.startIndex, offsetBy: 2) ..< str.characters.index(str.startIndex, offsetBy: 4))])
        //g
        let bStr = String(str[Range(str.characters.index(str.startIndex, offsetBy: 4) ..< str.characters.index(str.startIndex, offsetBy: 6))])
        
        //Scan values
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    func isLighterColor() -> Bool{

        let components = self.cgColor.components
        if components!.count > 2{
            
           return (components![0] + components![1] + components![2]) / 3 >= 0.5
        }else{
            return components![0]  >= 0.5
        }
        
    }
    
    func lighterColor() -> UIColor{
        if self == UIColor.white{
            return self
        }
        if self == UIColor.black{
            return UIColor(white: 0.01, alpha: 1.0)
        }
        let hue = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let saturation = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let brightness = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let alpha = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let white = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        if self.getHue(hue, saturation: saturation, brightness: brightness, alpha: alpha){
            return UIColor(hue: hue.pointee, saturation: saturation.pointee, brightness: min(brightness.pointee * 1.3, 1.0), alpha: alpha.pointee)
        }else if self.getWhite(white, alpha: alpha){
            return UIColor(white: min(brightness.pointee * 1.3, 1.0), alpha: alpha.pointee)
        }
        return self
    }
    
    func darkerColor() -> UIColor{
        if self == UIColor.white{
            return UIColor(white: 0.99, alpha: 1.0)
        }
        if self == UIColor.black{
            return self
        }
        let hue = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let saturation = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let brightness = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let alpha = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        let white = UnsafeMutablePointer<CGFloat>.allocate(capacity: 1)
        if self.getHue(hue, saturation: saturation, brightness: brightness, alpha: alpha){
            return UIColor(hue: hue.pointee, saturation: saturation.pointee, brightness: brightness.pointee * 0.75, alpha: alpha.pointee)
        }else if self.getWhite(white, alpha: alpha){
            return UIColor(white: max(white.pointee * 0.75, 0.0), alpha: alpha.pointee)
        }
        return self
    }
}
