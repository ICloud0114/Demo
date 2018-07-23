//
//  ViewController.swift
//  Repair
//
//  Created by ICloud on 2018/7/12.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var address:AddressPickView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func showAddressSelectionViewAction(_ sender: Any) {
        
        if address == nil{
            address = AddressPickView(frame: self.view.frame)
            self.view.addSubview(address)
        }
        address.showAddressPickerView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

