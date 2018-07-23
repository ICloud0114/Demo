//
//  ICTableViewCell.swift
//  TraceDemo
//
//  Created by ICloud on 2018/6/21.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICTableViewCell: UITableViewCell {

    var leftView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftView = stackView.arrangedSubviews.first
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    func adjustUI(_ adjust: Bool){
        if adjust{
            stackView.removeArrangedSubview(leftView)
            leftView.removeFromSuperview()
        }else{
            stackView.insertArrangedSubview(leftView, at: 0)
        }
    }

}
