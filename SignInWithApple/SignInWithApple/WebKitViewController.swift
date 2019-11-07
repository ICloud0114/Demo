//
//  WebKitViewController.swift
//  SignInWithApple
//
//  Created by ICloud on 2019/10/15.
//  Copyright © 2019 ICloud. All rights reserved.
//

import UIKit
import WebKit
class WebKitViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "http://www.xgdq.com/apptools-gour.html?code=AzQHYwJwACBWOAA9BmUCcFIiWy8GalwuVChaLFx9UClUKgt4UjJUYlAjUH4GbgBAmtWfVd2WGQHJFB3BzwGbQM%2BB24CYAAgVgsAaQZpAjlSZ1tnBmhcNlQwWm4%3D")!
        webView.load(URLRequest(url: url))
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
