//
//  ICCollectionViewFlowLayout.swift
//  TraceDemo
//
//  Created by ICloud on 2018/6/26.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ICCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.itemSize = CGSize(width: 375, height: 375)
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsetsMake(0, 37.5, 0, 37.5 )
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.itemSize = CGSize(width: 375, height: 375)
        self.scrollDirection = .horizontal
        self.sectionInset = UIEdgeInsetsMake(0, 37.5, 0, 37.5 )
        
    }
}
