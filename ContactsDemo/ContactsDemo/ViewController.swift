//
//  ViewController.swift
//  ContactsDemo
//
//  Created by ICloud on 2018/7/25.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit
import ContactsUI
class ViewController: UIViewController {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addContactsAction(_ sender: Any) {
        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
            if isRight {
                self.loadContactsPickerVC()
            }else{
                self.showAlertVC()
            }
        }
        
    }
    
    func loadContactsPickerVC() {
        let picker = CNContactPickerViewController()
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count >0 and (givenName != '' || familyName != '')", argumentArray: nil)
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
    }
    
    func showAlertVC(){
        let alertVC = UIAlertController(title: "通讯录未授权", message: "您尚未开启迅宿智能锁APP通讯录授权，不能使用该功能。请到”设置-迅宿智能锁-通讯录“中开启", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "去设置", style: UIAlertActionStyle.destructive, handler: { (settingAction) in
            let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)!
            if UIApplication.shared.canOpenURL(settingUrl as URL)
            {
                UIApplication.shared.open(settingUrl as URL, options: [:], completionHandler: { (istrue) in
                })
            }
        })
        alertVC.addAction(cancel)
        alertVC.addAction(setting)
        self.present(alertVC, animated: true, completion: {
            
        })
        
        printData("------")
        
        printData(notify: "-------")
        
        printData(data: "-------")
        
    }
    
    
    func printData(_ data: String) {
        
    }
    
    func printData(notify data: String ){
        
    }
    
    func printData(data: String){
        
    }
    
}


extension ViewController:CNContactPickerDelegate{
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        fullName.text = contactProperty.contact.familyName  + contactProperty.contact.givenName
        if contactProperty.key == "phoneNumbers"{
            let phone = contactProperty.value as! CNPhoneNumber
        phoneNumber.text = phone.stringValue
        }else{
            phoneNumber.text = ""
        }
    }
}
