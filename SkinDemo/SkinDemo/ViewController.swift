//
//  ViewController.swift
//  SkinDemo
//
//  Created by ICloud on 2019/4/9.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }

    @IBAction func whiteSkinAction(_ sender: Any) {
        ThemeManager.instance.updateThemeStyle(.white)
        setupUI()
    }
    
    @IBAction func blackSkinAction(_ sender: Any) {
        ThemeManager.instance.updateThemeStyle(.default)
        setupUI()
    }
    
    func setupUI(){
        
        logo.image = UIImage.loadImage("personalcenter_logo")
        titleLabel.textColor = UIColor("styleTitle")
    }
}

