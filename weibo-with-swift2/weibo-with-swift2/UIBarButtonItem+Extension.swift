//
//  UIBarButtonItem+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 便利构造函数
    ///
    /// - parameter imageName: imageName
    /// - parameter target:    target
    /// - parameter action:    action
    ///
    /// - returns: UIBarButtonItem
    convenience init(imageName: String, target: AnyObject?, action: String?) {
        
        let button = UIButton(imageName: imageName, backImageName: nil)
        
        // 判断 action 是否存在
        if let actionName = action {
            // 添加按钮监听方法
            button.addTarget(target, action: Selector(actionName), forControlEvents: .TouchUpInside)
            
        }
        
        // 提示：没有智能提示
        self.init(customView: button)
    }
}

