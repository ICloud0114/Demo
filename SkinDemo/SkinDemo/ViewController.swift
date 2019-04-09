//
//  ViewController.swift
//  SkinDemo
//
//  Created by ICloud on 2019/4/9.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ThemeManager.instance.updateThemeStyle(.white)
        logo.image = ThemeManager.instance.loadImage("personalcenter_logo")
    }

    @IBAction func whiteSkinAction(_ sender: Any) {
        logo.image = ThemeManager.instance.loadImage("login_logo")
       
    }
    
    @IBAction func blackSkinAction(_ sender: Any) {
        
    }
}

