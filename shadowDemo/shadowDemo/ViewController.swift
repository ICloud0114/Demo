//
//  ViewController.swift
//  shadowDemo
//
//  Created by ICloud on 13/9/18.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var redView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        redView.layer.cornerRadius = 20
        redView.layer.shadowOpacity = 1
        redView.layer.shadowRadius = 5
        redView.layer.borderColor = UIColor.gray.cgColor
        redView.layer.borderWidth = 0.3
        redView.layer.shadowColor = UIColor.black.cgColor
        redView.layer.shadowOffset = CGSize.zero

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roundIdentifier", for: indexPath) as! RoundTableViewCell
        
        return cell
    }
}
