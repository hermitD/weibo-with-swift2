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
    
    /*
    + (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
    {
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    */
    convenience init(imageName: String, highImage: String, target: AnyObject?, action: String?) {
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
        button.setBackgroundImage(UIImage(named: highImage), forState: .Highlighted)
        button.sizeToFit()
        if let actionName = action{
            button.addTarget(target, action: Selector(actionName), forControlEvents: .TouchUpInside)
        }
        self.init(customView: button)
    }
    
}

