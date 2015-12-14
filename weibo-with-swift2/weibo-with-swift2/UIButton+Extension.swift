//
//  UIButton+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(imageName: String, backImageName: String?) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        if backImageName != nil {
            setBackgroundImage(UIImage(named: backImageName!), forState: UIControlState.Normal)
            setBackgroundImage(UIImage(named: backImageName! + "_highlighted"), forState: UIControlState.Highlighted)
        }
        sizeToFit()
    }
    
    convenience init(title: String, fontSize: CGFloat, color: UIColor, backImageName: String) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    
}
