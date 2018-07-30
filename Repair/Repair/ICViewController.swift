//
//  ICViewController.swift
//  Repair
//
//  Created by ICloud on 2018/7/20.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICViewController: UIViewController {
    var address:AddressPickView!
    
    
    deinit {
        print("--------deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func showAddressSelectionViewAction(_ sender: Any) {
        
        if address == nil{
            address = AddressPickView(frame: self.view.frame)
            self.view.addSubview(address)
        }
        address.delegate = self
        address.showAddressPickerView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ICViewController: AddressPickViewDelegate{
    func didFinishSelectArea(area: String, pickerView: AddressPickView) {
        address.delegate = nil
    }
    
    func didCancelSelectArea() {
        address.delegate = nil
    }
    
    
    
}
