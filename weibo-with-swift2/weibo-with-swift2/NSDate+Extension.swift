//
//  NSDate+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

extension NSDate {
    
    /// 将新浪微博日期格式的字符串转换成 NSDate
    class func sinaDate(string: String) -> NSDate? {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        return df.dateFromString(string)
    }
    
    /**
    根据当前日期，返回对应的格式描述文字
    
    刚刚(一分钟内)
    X分钟前(一小时内)
    X小时前(当天)
    昨天 HH:mm(昨天)
    MM-dd HH:mm(一年内)
    yyyy-MM-dd HH:mm(更早期)
    */
    var dateDescription: String {
        
        // 获取当前日历 NSCalendar 提供了非常丰富的日历处理函数
        let canlender = NSCalendar.currentCalendar()
        
        if canlender.isDateInToday(self) {
            
            // 计算指定日期和当前系统时间的时间差
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            
            return "\(delta / 3600) 小时前"
        }
        
        // 更早期的处理
        var fmt = " HH:mm"
        
        if canlender.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        } else {
            
            fmt = "MM-dd" + fmt
            
            // 单纯根据年的数字判断
            // print(canlender.component(.Year, fromDate: self))
            // 使用对比，能够判断两个日期之间是否有一个完整的`年度`差
            let coms = canlender.components(.Year, fromDate: self, toDate: NSDate(), options: [])
            
            if coms.year != 0 {
                fmt = "yyyy-" + fmt
            }
        }
        
        // 日期转换
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = fmt
        
        return df.stringFromDate(self)
    }
}
