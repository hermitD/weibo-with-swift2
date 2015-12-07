//
//  UIButton+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
// extension 类似于 OC 中的分类，作用是对现有的类`扩展`方法！
// 扩展中不允许编写指定构造函数！只能添加便利构造函数，(OC中可以定义类函数)
// extension 中同样不能定义`存储型`的属性！
extension UIButton {
    
    /// 便利构造函数
    ///
    /// - parameter imageName:     imageName
    /// - parameter backImageName: 背景图像名称
    ///
    /// - returns: UIButton
    convenience init(imageName: String, backImageName: String?) {
        // 实例化按钮
        self.init()
        
        // 设置按钮属性
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        if backImageName != nil {
            setBackgroundImage(UIImage(named: backImageName!), forState: UIControlState.Normal)
            setBackgroundImage(UIImage(named: backImageName! + "_highlighted"), forState: UIControlState.Highlighted)
        }
        
        // 自动调整大小
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:         title
    /// - parameter fontSize:      fontSize
    /// - parameter color:         color
    /// - parameter backImageName: backImageName
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, backImageName: String) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter fontSize:  fontSize
    /// - parameter color:     color
    /// - parameter imageName: imageName
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
//    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String, actionName: String) {
//        self.init()
//        
//        setTitle(title, forState: UIControlState.Normal)
//        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
//        setTitleColor(color, forState: UIControlState.Normal)
//        
//        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
//        
//        
//    }
    
}
