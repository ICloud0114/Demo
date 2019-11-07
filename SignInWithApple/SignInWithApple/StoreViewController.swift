//
//  StoreViewController.swift
//  SignInWithApple
//
//  Created by ICloud on 2019/10/15.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit

class StoreViewController: WebViewController {

    override init(url: URL?) {
           super.init(url: url)
       }
   
   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let url = URL(string: "https://wxsports.ydmap.cn/page.shtml?id=101958")!
       let url = URL(string: "http://www.xgdq.com/apptools-gourl.html?code=AzQDZwR2BCRUOldqAWIAclAgUSVSPgt5AHxTJQIjAXhWKFUmBmYDNQd0AS8Gbg5nVz5SeVFwDjIAI1B3XGdSOQM%2BA2oEZgQkVAlXPgFuADtQZVFtUjwLYQBkU2c%3D")!
        self.load(url)
    }
    

    /*s
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
