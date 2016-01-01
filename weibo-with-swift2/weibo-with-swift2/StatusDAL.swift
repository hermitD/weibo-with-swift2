//
//  StatusDAL.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

private let dbCacheDate: NSTimeInterval = 60 // 7 * 24 * 60 * 60

class StatusDAL {

    class func clearCache() {
        
        let date = NSDate(timeIntervalSinceNow: -dbCacheDate)
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateStr = df.stringFromDate(date)
        
        let sql = "DELETE FROM T_Status WHERE createTime < ?"
        
        SQLiteManager.sharedManager.queue.inTransaction { (db, _) -> Void in
            db.executeUpdate(sql, dateStr)
            //print("clear \(db.changes()) rocords")
        }
    }
    
    class func loadStatus(since_id: Int, max_id: Int, completion: (array: [[String: AnyObject]]?, error: NSError?) -> ()) {

        cacheStats(since_id, max_id: max_id) { (array) -> () in
            
            if array?.count > 0 {
                //print("get \(array?.count) catch record")
                completion(array: array, error: nil)
                
                return
            }
            
            NetworkTools.sharedTools.loadStatus(since_id, max_id: max_id, finished: { (result, error) -> () in
                
                if error != nil {
                    completion(array: nil, error: error)
                    return
                }
                
                guard let array = result?["statuses"] as? [[String: AnyObject]] else {
                    completion(array: nil, error: NSError(domain: "cn.doyere.error", code: 300, userInfo: ["message": "dataformat error"]))
                    return
                }
                
                StatusDAL.saveStatusData(array)
                completion(array: array, error: nil)
            })
        }
    }
    

    private class func cacheStats(since_id: Int, max_id: Int, finished: (array: [[String: AnyObject]]?) -> ()) {

        assert(UserAccountViewModel.sharedAccountViewModel.userLogon, "user unlogin")
        
        let userId = UserAccountViewModel.sharedAccountViewModel.userAccount!.uid!
        
        var sql = "SELECT statusId, status, userId FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        } else if max_id > 0 {
            sql += "AND statusId < \(max_id) \n"
        }
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        //print(sql)
        
        SQLiteManager.sharedManager.recordSet(sql) { (array) -> () in
            
            guard let recordSet = array else {
                finished(array: nil)
                return
            }
            var result = [[String: AnyObject]]()
            
            for dict in recordSet {
                let json = dict["status"] as! NSData
                
                let jsonDict = try! NSJSONSerialization.JSONObjectWithData(json, options: [])
                
                result.append(jsonDict as! [String : AnyObject])
            }
            finished(array: result)
        }
    }
    
    private class func saveStatusData(array: [[String: AnyObject]]) {
        
        assert(UserAccountViewModel.sharedAccountViewModel.userLogon, "user unlogin")
        
        
        let sql = "INSERT OR REPLACE INTO T_Status (statusId, status, userId) VALUES (?, ?, ?);"
        

        let userId = UserAccountViewModel.sharedAccountViewModel.userAccount!.uid!
        
        SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
            
            for dict in array {
                let statusId = dict["id"] as! Int
                let json = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
                
                if !db.executeUpdate(sql, statusId, json, userId) {
                    rollback.memory = true
                    break
                }
            }
        }
    }
}