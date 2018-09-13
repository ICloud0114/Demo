//
//  RoundTableViewCell.swift
//  shadowDemo
//
//  Created by ICloud on 14/9/18.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class RoundTableViewCell: UITableViewCell {

    
    @IBOutlet weak var roundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        roundView.layer.cornerRadius = 10
        roundView.layer.shadowColor = UIColor.black.cgColor
        roundView.layer.shadowRadius = 5
        roundView.layer.shadowOpacity = 0.8
        roundView.layer.shadowOffset = CGSize.zero
        roundView.layer.borderColor = UIColor.gray.cgColor
        roundView.layer.borderWidth = 0.3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
