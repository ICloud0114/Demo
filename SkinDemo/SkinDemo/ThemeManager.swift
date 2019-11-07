//
//  ThemeManager.swift
//  SkinDemo
//
//  Created by ICloud on 2019/4/9.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

let kUpdateTheme = "kUpdateTheme"
let kThemeStyle = "kThemeStyle"

final class ThemeManager: NSObject {
    
    var style: ThemeStyle {
        return themeStyle
    }
    
    static var instance = ThemeManager()
    
    private var themeBundleName: String {
        switch themeStyle {
        case .white:
            return "WhiteSkin"
        default:
            return "DefaultSkin"
        }
    }
    // 缓存 image 到内存中，提高重复访问的速度
    private let memoryCache = NSCache<NSString, UIImage>()
    private var themeStyle: ThemeStyle = .default
    private var themeColors: NSDictionary?
    private var screenScale: UInt8 = 2
    
    private override init() {
        super.init()
        if let style = UserDefaults.standard.object(forKey: kThemeStyle) as? Int {
            themeStyle = ThemeStyle(rawValue: style)!
        } else {
            UserDefaults.standard.set(themeStyle.rawValue, forKey: kThemeStyle)
            UserDefaults.standard.synchronize()
        }
        screenScale = UInt8(UIScreen.main.scale)
        themeColors = getThemeColors()
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(clearMemoryCache), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func clearMemoryCache() {
        memoryCache.removeAllObjects()
    }
    
    private func getThemeColors() -> NSDictionary? {
        
        guard let themeBundlePath = Bundle.path(forResource: themeBundleName, ofType: "bundle", inDirectory: Bundle.main.bundlePath) else {
            return nil
        }
        guard let themeBundle = Bundle(path: themeBundlePath) else {
            return nil
        }
        guard let path = themeBundle.path(forResource: "colors", ofType: "plist") else {
            return nil
        }
        
        guard let data = NSDictionary(contentsOfFile: path) else{
            return nil
        }
        return data
    }
    
    public func updateThemeStyle(_ style: ThemeStyle) {
        if themeStyle.rawValue == style.rawValue {
            return
        }
        themeStyle = style
        UserDefaults.standard.set(style.rawValue, forKey: kThemeStyle)
        UserDefaults.standard.synchronize()
        themeColors = getThemeColors()
        memoryCache.removeAllObjects()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUpdateTheme), object: nil)
    }
    
    public func themeColor(_ colorName: String) -> Int {
        guard let hexString = themeColors?.value(forKey: colorName) as? String else {
            assert(true, "Invalid color key")
            return 0
        }
        let colorValue = Int(strtoul(hexString, nil, 16))
        return colorValue
    }
    
    // MARK: load image
    public func loadImage(_ imageName: String) -> UIImage? {
        return loadImage(imageName, themeStyle)
    }
    
    public func loadImage(_ imageName: String, _ style: ThemeStyle) -> UIImage? {
        
        if imageName.isEmpty || imageName.count == 0 {
            return nil
        }
        var nameAndType = imageName.components(separatedBy: ".")
        let name = nameAndType.first!
        
        if let image = memoryCache.object(forKey: name as NSString) {
            return image
        }
        
        guard let themeBundlePath = Bundle.path(forResource: self.themeBundleName, ofType: "bundle", inDirectory: Bundle.main.bundlePath) else {
            return nil
        }
        
        guard let themeBundle = Bundle(path: themeBundlePath) else {
            return nil
        }
        
        let type = nameAndType.count > 1 ? nameAndType[1] : "png"
        let scaleSuffix = "@" + "\(screenScale)" + "x"
        guard let imagePath = themeBundle.path(forResource: "images/" + name + scaleSuffix, ofType: type) else{
            return UIImage(named: imageName)
        }
        
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return UIImage(named: imageName)
        }
        memoryCache.setObject(image, forKey: name as NSString)
        return image
    }
    
}

