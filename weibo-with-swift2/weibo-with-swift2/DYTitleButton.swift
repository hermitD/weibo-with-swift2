//
//  DYTitleButton.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/17.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class DYTitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        let backImage = UIImage(named: "navigationbar_filter_background_highlighted")
        backImage?.stretchHalf()
        setBackgroundImage(backImage, forState: .Highlighted)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        sizeToFit()
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if currentImage == nil {
            return
        }
        if (titleLabel?.x() != CGFloat(0) && imageView?.x() != CGFloat(0)) {
            return
        }
        titleLabel?.setX(self.imageView!.x())
        imageView?.setX(CGRectGetMaxX((titleLabel?.frame)!))
        
    }
    
}
