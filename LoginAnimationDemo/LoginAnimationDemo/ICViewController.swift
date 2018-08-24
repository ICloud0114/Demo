//
//  ICViewController.swift
//  LoginAnimationDemo
//
//  Created by ICloud on 2018/8/24.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICViewController: UIViewController {

    @IBOutlet weak var redBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            
            self.redBox.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height + self.redBox.frame.height / 2)
            
        }) { _ in
            
        }
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
