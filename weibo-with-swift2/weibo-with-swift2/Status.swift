//
//  Status.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class Status: NSObject {
    var id: Int = 0
    var created_at: String?
    var text: String?
    var source: String? {
        didSet{
            source = source?.href()?.text
        }
    }
    var user: User?
    var retweeted_status: Status?
    var pic_urls: [[String: String]]?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            user = User(dict: value as! [String: AnyObject])
            return
        }
        if key == "retweeted_status" {
            retweeted_status = Status(dict: value as! [String: AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["id", "created_at", "text", "source", "user", "pic_urls", "retweeted_status"]
        //KNOW KVC
        return dictionaryWithValuesForKeys(keys).description

    }
    
    
    
}



/*

override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

override var description: String {
let keys = ["id", "created_at", "text", "source", "user", "pic_urls", "retweeted_status"]

return dictionaryWithValuesForKeys(keys).description
}

*/