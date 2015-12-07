//
//  UIImage+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 将图像缩放到`指定宽度`
    ///
    /// - parameter width: 图片宽度，如果图像宽度已经小于指定宽度，直接返回
    ///
    /// - returns: UIImage
    func scaleImage(width: CGFloat) -> UIImage {
        
        // 1. 判断图像宽度
        if width > size.width {
            return self
        }
        
        // 2. 根据宽度计算比例
        let height = size.height * width  / size.width
        // 生成图像的大小
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3. 绘制新图像
        // 1> 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2> 绘制图像 － 在 rect 中缩放填充绘制图像
        drawInRect(rect)
        
        // 3> 取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4> 关闭上下文
        UIGraphicsEndImageContext()
        
        // 5> 返回结果
        return result
    }
}
