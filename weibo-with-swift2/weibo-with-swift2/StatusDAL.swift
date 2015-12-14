//
//  StatusDAL.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation

private let dbCacheDate: NSTimeInterval = 60 // 7 * 24 * 60 * 60

/// 微博数据数据访问层
class StatusDAL {
    
    /**
    - SQLITE 的数据库，会随着数据的增加，数据库文件会不断的变大
    - 但是，如果删除了记录，数据库文件并不会变小
    - 留出空间为新增数据使用
    
    如果忽视了SQLite的缓存清理，会让程序占用磁盘空间增长的非常可怕！
    */
    /// 清理本地数据缓存，清理指定时间的缓存数据
    class func clearCache() {
        
        // 1. 解决日期的问题
        let date = NSDate(timeIntervalSinceNow: -dbCacheDate)
        
        // 2. 日期转换
        let df = NSDateFormatter()
        // 提示：区域参数在模拟器上可以不指定，但是真机一定需要
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateStr = df.stringFromDate(date)
        
        // 3. 准备 SQL（提示，测试的时候一定用 SELECT *，在开发时再替换成 DELETE）
        let sql = "DELETE FROM T_Status WHERE createTime < ?"
        
        // 4. 执行 SQL
        SQLiteManager.sharedManager.queue.inTransaction { (db, _) -> Void in
            db.executeUpdate(sql, dateStr)
            print("清除了 \(db.changes()) 条记录")
        }
    }
    
    /// 从本地或者网络加载微博数据
    class func loadStatus(since_id: Int, max_id: Int, completion: (array: [[String: AnyObject]]?, error: NSError?) -> ()) {
        
        // 1. 检查是否存在本地缓存数据
        cacheStats(since_id, max_id: max_id) { (array) -> () in
            
            // 2. 如果有，返回缓存数据
            if array?.count > 0 {
                print("有 \(array?.count) 条缓存数据")
                completion(array: array, error: nil)
                
                return
            }
            
            // 3. 如果没有，加载网络数据
            NetworkTools.sharedTools.loadStatus(since_id: since_id, max_id: max_id, finished: { (result, error) -> () in
                
                if error != nil {
                    completion(array: nil, error: error)
                    return
                }
                
                // 1. 取出网络返回字典中的微博数组
                guard let array = result?["statuses"] as? [[String: AnyObject]] else {
                    completion(array: nil, error: NSError(domain: "cn.itcast.error", code: -1001, userInfo: ["message": "数据格式错误"]))
                    return
                }
                
                // 4. 将网络数据保存至本地
                StatusDAL.saveStatusData(array)
                
                // 5. 返回数据
                completion(array: array, error: nil)
            })
        }
    }
    
    /// 检查本地缓存数据
    /// 需要返回`缓存数据` -> 通过回调返回
    /// 检查`网络方法`确定参数
    private class func cacheStats(since_id: Int, max_id: Int, finished: (array: [[String: AnyObject]]?) -> ()) {
        print("===> \(since_id) \(max_id)")
        
        // 断言，要求用户登录成功再调用此参数
        assert(UserAccountViewModel.sharedAccountViewModel.userLogon, "用户没有登录")
        
        let userId = UserAccountViewModel.sharedAccountViewModel.userAccount!.uid!
        
        // 准备测试好的 SQL
        var sql = "SELECT statusId, status, userId FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        
        // 上拉 & 下拉处理
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        } else if max_id > 0 {
            sql += "AND statusId < \(max_id) \n"
        }
        // SQL 的收尾
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        print(sql)
        
        SQLiteManager.sharedManager.recordSet(sql) { (array) -> () in
            
            // 没有找到本地的缓存数据
            guard let recordSet = array else {
                finished(array: nil)
                return
            }
            
            // 定义字典数据
            var result = [[String: AnyObject]]()
            
            // 遍历 array 的数组，从字典的 status 值中获取 JSON 字符串
            for dict in recordSet {
                let json = dict["status"] as! NSData
                
                // 反序列化成`字典`
                let jsonDict = try! NSJSONSerialization.JSONObjectWithData(json, options: [])
                
                // 追加字典
                result.append(jsonDict as! [String : AnyObject])
            }
            
            // 完成回调，返回本地缓存的字典数组
            finished(array: result)
        }
    }
    
    /// 将`网络数据[字典数组]`保存到本地数据库
    private class func saveStatusData(array: [[String: AnyObject]]) {
        
        // 断言，要求用户登录成功再调用此参数
        assert(UserAccountViewModel.sharedAccountViewModel.userLogon, "用户没有登录")
        
        // 准备测试好的 SQL
        /**
        statusId 是每条微博的 id
        status 是一条完整微博的 json 字符串
        userId 是当前登录用户的 id
        */
        let sql = "INSERT OR REPLACE INTO T_Status (statusId, status, userId) VALUES (?, ?, ?);"
        
        // 根据 SQL 来准备参数
        // 1> 用户 id - 用户登录成功才会有值
        let userId = UserAccountViewModel.sharedAccountViewModel.userAccount!.uid!
        
        SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
            
            // 遍历数组
            for dict in array {
                let statusId = dict["id"] as! Int
                
                // 对字典进行序列化 -> 二进制数据
                let json = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
                
                // 插入数据库
                if !db.executeUpdate(sql, statusId, json, userId) {
                    rollback.memory = true
                    break
                }
            }
        }
    }
}