//
//  TopCollectionViewCell.swift
//  Top4Swift
//
//  Created by james on 14-12-17.
//  Copyright (c) 2014年 woowen. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    //cell constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
