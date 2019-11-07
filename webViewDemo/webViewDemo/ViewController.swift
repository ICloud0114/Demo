//
//  ViewController.swift
//  webViewDemo
//
//  Created by ICloud on 2019/10/15.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func showWebView(_ sender: Any) {
        let vc = StoreViewController(url: nil)
        self.present(vc, animated: true) {
            
        }
    }
    
}

