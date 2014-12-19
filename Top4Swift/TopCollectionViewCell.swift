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
    
//    @IBOutlet weak var vImageSearchCell: NSLayoutConstraint!
//
//    @IBOutlet weak var HSearchCellImage: NSLayoutConstraint!
//    
//    @IBOutlet weak var HImageSearchCell: NSLayoutConstraint!
//    
//    @IBOutlet weak var VSearchLabel: NSLayoutConstraint!
//    
//    @IBOutlet weak var VLabelImage: NSLayoutConstraint!
//    
//    @IBOutlet weak var HSearchCellLabel: NSLayoutConstraint!
//    
//    @IBOutlet weak var HLabelSearchCell: NSLayoutConstraint!
//    
//    @IBOutlet weak var HLabel: NSLayoutConstraint!
//    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
//    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
//        
//        let preferredLayoutAttributes = layoutAttributes.copy() as UICollectionViewLayoutAttributes
//        
////        let quoteLabelSize = self.cellImage.sizeThatFits(CGSizeMake(CGRectGetWidth(preferredLayoutAttributes.frame) - self.quoteLabelLeftConstraint.constant - self.quoteLabelRightConstraint.constant, CGFloat.max))
//        let quoteLabelSize = self.cellImage.sizeThatFits(CGSizeMake(CGRectGetWidth(preferredLayoutAttributes.frame), CGFloat.max))
//        
//        var frame = preferredLayoutAttributes.frame
//        
//        frame.size.height = self.vImageSearchCell.constant + quoteLabelSize.height
////        println(frame.size.height)
//        
////        frame.size.height = self.quoteLabelTopConstraint.constant + quoteLabelSize.height + self.quoteLabelBottomConstraint.constant
//        preferredLayoutAttributes.frame = frame
//        return preferredLayoutAttributes
//    }

}
