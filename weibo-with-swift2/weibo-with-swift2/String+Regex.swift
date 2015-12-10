//
//  String+Regex.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

extension String {
    
    /// 从当前字符串中获取链接和文本，`元组`->一个函数返回多个数值
    func href() -> (link: String, text: String)? {
        
        // 匹配方案 － 过滤的方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        guard let result = regex.firstMatchInString(self, options: [], range: NSRange(location: 0, length: self.characters.count)) else {
            return nil
        }
        
        let link = (self as NSString).substringWithRange(result.rangeAtIndex(1))
        let text = (self as NSString).substringWithRange(result.rangeAtIndex(2))
        
        return (link, text)
    }
}