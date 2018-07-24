//
//  ViewController.swift
//  Contacts
//
//  Created by ICloud on 2018/7/24.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit
import ContactsUI
class ViewController: UIViewController,CNContactPickerDelegate{

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cellPhone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectContactAction(_ sender: Any) {
        
        let picker = CNContactPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    
    private func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        contact
        
    }
    
    private func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        
    }

}

