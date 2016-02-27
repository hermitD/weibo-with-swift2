//
//  UIView+Frame.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/16.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIView {
    
    func setX(x: CGFloat) {
        self.frame.origin.x = x
    }
    
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    func setY(y: CGFloat) {
        self.frame.origin.y = y
    }
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
//    func setWidth(width: CGFloat) {
//        self.frame.size.width = width
//    }
//    func width() -> CGFloat {
//        return self.frame.size.width
//    }
//    
//    func setHeight(height: CGFloat) {
//        self.frame.size.height = height
//    }
//    func height() -> CGFloat {
//        return self.frame.size.height
//    }
    
}