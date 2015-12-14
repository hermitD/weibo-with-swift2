//
//  UIBarButtonItem+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String, target: AnyObject?, action: String?) {
        
        let button = UIButton(imageName: imageName, backImageName: nil)
        
        if let actionName = action {
            button.addTarget(target, action: Selector(actionName), forControlEvents: .TouchUpInside)
            
        }
        self.init(customView: button)
    }
}

