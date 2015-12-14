//
//  UILabel+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UILabel {
    

    convenience init(title: String, color: UIColor, fontSize: CGFloat, layoutWidth: CGFloat = 0) {
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        
        if layoutWidth > 0 {
            preferredMaxLayoutWidth = layoutWidth
            textAlignment = .Left
        } else {
            textAlignment = .Center
        }
        
        sizeToFit()
    }
}
