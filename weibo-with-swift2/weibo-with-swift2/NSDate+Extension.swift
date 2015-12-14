//
//  NSDate+Extension.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

extension NSDate {
    
    /// SinaDate -> NSDate
    class func sinaDate(string: String) -> NSDate? {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        return df.dateFromString(string)
    }
    

    var dateDescription: String {
        
        let canlender = NSCalendar.currentCalendar()
        
        if canlender.isDateInToday(self) {
            
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            
            if delta < 60 {
                return "just now"
            }
            if delta < 3600 {
                return "\(delta / 60) minutes before"
            }
            
            return "\(delta / 3600) hours ago"
        }
        
        var fmt = " HH:mm"
        
        if canlender.isDateInYesterday(self) {
            fmt = "Yesterday" + fmt
        } else {
            
            fmt = "MM-dd" + fmt
            
            let coms = canlender.components(.Year, fromDate: self, toDate: NSDate(), options: [])
            
            if coms.year != 0 {
                fmt = "yyyy-" + fmt
            }
        }
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = fmt
        
        return df.stringFromDate(self)
    }
}
