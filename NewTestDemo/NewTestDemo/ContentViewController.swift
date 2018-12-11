//
//  ContentViewController.swift
//  NewTestDemo
//
//  Created by ICloud on 12/12/2018.
//  Copyright © 2018 ICloud. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var pageIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "\(pageIndex)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
