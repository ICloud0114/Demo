//
//  UIColor+Generator.swift
//  SolarEnergy
//
//  Created by Topband on 2017/12/8.
//  Copyright © 2017年 Topband. All rights reserved.
//

import UIKit

extension UIColor {
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
    
}

