//
//  ICCollectionViewCell.swift
//  TraceDemo
//
//  Created by ICloud on 2018/6/26.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICCollectionViewCell: UICollectionViewCell {
    
    @IBAction func clickAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        print("--------->>>>>>")
        let urlString = "itms-apps://itunes.apple.com/cn/app/id1405468632"
        guard let url = URL(string: urlString) else{
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                        (success) in
            })
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
}
