//
//  UIImage+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIImage {
    

    func scaleImage(width: CGFloat) -> UIImage {
        
        if width > size.width {
            return self
        }
        
        let height = size.height * width  / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        drawInRect(rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    
    }
    
     func stretchHalf() {
        
        /*
        var myImage = UIImage(named: "navbar.png")!
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(13, 37, 13, 37)
        myImage = myImage.resizableImageWithCapInsets(myInsets)
        */
        stretchableImageWithLeftCapWidth(Int(self.size.width) / 2, topCapHeight: Int(self.size.height) / 2)
    }
    
    
}
