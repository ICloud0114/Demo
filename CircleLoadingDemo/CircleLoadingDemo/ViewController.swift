//
//  ViewController.swift
//  CircleLoadingDemo
//
//  Created by ICloud on 2018/10/29.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleLoadingView: loadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let loading = loadingView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        loading.beginAnimation()
//        view.addSubview(loading)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleLoadingView.beginAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

