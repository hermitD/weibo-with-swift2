//
//  UserAccount.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/8.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

//combine two
//https://api.weibo.com/oauth2/access_token
//https://api.weibo.com/2/users/show.json


class UserAccount: NSObject, NSCoding{
    var access_token: String?
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    var expiresDate: NSDate?
    var uid: String?
    var screen_name: String?
    var avatar_large: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override init() {
        super.init()
    }
    
    
    //this tool may change class?
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    var accountPath:String {
        return dataFilePath()
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        return
    }
    
    override var description: String {
        let keys = ["access_token", "expires_in", "expiresDate", "uid", "screen_name", "avatar_large"]
        //dictionaryWithValuesForKeys KVC method
        return "\(self.dictionaryWithValuesForKeys(keys))"

    }
    
    
    func loadUserAccount() {
//        let path = dataFilePath()
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            if let data = NSData(contentsOfFile: path) {
//                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
//                unarchiver.finishDecoding()
//                sortChecklists()
//            }
//        }
        if let unarchiver = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) {
            print(unarchiver)
        }else{
            print("havenovalue")
        }
        
    }
    
    func saveUserAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: accountPath)
        
    }
    
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        //use Date not Datetime? use datetime may have some bugs?
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")

    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        super.init()
    }
    
}
