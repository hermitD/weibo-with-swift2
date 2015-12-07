//
//  UILabel+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 便利构造函数
    ///
    /// - parameter title:          title
    /// - parameter color:          color
    /// - parameter fontSize:       fontSize
    /// - parameter layoutWidth:    文本换行宽度，默认为0
    ///
    /// - returns: UILabel
    /// - 如果指定换行宽度，是左对齐，否则是居中对齐
    convenience init(title: String, color: UIColor, fontSize: CGFloat, layoutWidth: CGFloat = 0) {
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFontOfSize(fontSize)
        numberOfLines = 0
        
        if layoutWidth > 0 {
            // 指定多行文本的换行宽度
            preferredMaxLayoutWidth = layoutWidth
            textAlignment = .Left
        } else {
            textAlignment = .Center
        }
        
        sizeToFit()
    }
}
