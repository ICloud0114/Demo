//
//  ThemeProtocol.swift
//  SkinDemo
//
//  Created by ICloud on 2019/4/9.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

enum ThemeStyle: Int {
    case `default` = 0
    case white
}

protocol ThemeProtocol {
    
}
extension UIView {
    @objc func updateTheme() {
        print("--->update view theme")
    }
}

extension UIViewController {
    @objc func updateTheme() {
        print("--->update view controller theme")
    }
}

extension ThemeProtocol where Self: UIView {
    
    func addThemeObserver() {
        print("--->addViewThemeObserver")
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: NSNotification.Name(rawValue: kUpdateTheme), object: nil)
    }
    
    func removeThemeObserver() {
        print("--->removeViewThemeObserver")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kUpdateTheme), object: nil)
    }
    
}

extension ThemeProtocol where Self: UIViewController {
    
    func addThemeObserver() {
        print("--->addViewControllerThemeObserver")
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: NSNotification.Name(rawValue: kUpdateTheme), object: nil)
    }
    
    func removeThemeObserver() {
        print("--->removeViewControllerThemeObserver")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kUpdateTheme), object: nil)
    }
    
}
