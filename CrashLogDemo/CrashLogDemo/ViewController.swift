//
//  ViewController.swift
//  CrashLogDemo
//
//  Created by ICloud on 2019/11/5.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
///数组越界
    @IBAction func test1(_ sender: Any) {
        let arr = [1, 2, 3]
        _ = arr[3]
        
    }
    ///不存在
    @IBAction func test2(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        self.present(storyBoard.instantiateViewController(withIdentifier: "aaa"), animated: true, completion: nil)
    }
    ///子线程刷新
    @IBAction func test3(_ sender: Any) {
        
        let queue = DispatchQueue.global()
        queue.async() { () -> Void in
            let view = UIView()
            self.view.addSubview(view)
            view.backgroundColor = .black
        }
    }
    ///死循环 --无日志
    @IBAction func test4(_ sender: Any) {
        deadLoop()
    }
    func deadLoop(){
       test4("")
    }
    ///强转换
    @IBAction func test5(_ sender: Any) {
        
        let dic:[String: Any] = ["data": "info"]
        _ = dic["data"] as! Int
    }
    
    
    @IBAction func test6(_ sender: Any) {
    }
    
    @IBAction func test7(_ sender: Any) {
    }
    
    @IBAction func test8(_ sender: Any) {
    }
    
    @IBAction func test9(_ sender: Any) {
    }
    
    @IBAction func test10(_ sender: Any) {
    }
    
    @IBAction func test16(_ sender: Any) {
    }
    
    @IBAction func test17(_ sender: Any) {
    }
    
    @IBAction func test18(_ sender: Any) {
    }
    
    @IBAction func test19(_ sender: Any) {
    }
    
    @IBAction func test20(_ sender: Any) {
    }
    
    
    @IBAction func test26(_ sender: Any) {
    }
    
    @IBAction func test27(_ sender: Any) {
    }
    
    @IBAction func test28(_ sender: Any) {
    }
    
    @IBAction func test29(_ sender: Any) {
    }
    
    @IBAction func test30(_ sender: Any) {
    }
}

