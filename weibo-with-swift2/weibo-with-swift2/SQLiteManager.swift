//
//  SQLiteManager.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation
//import FMDB

/// 默认的数据库名称
private let dbName = "my.db"

/// SQLite管理器
class SQLiteManager {
    
    /// 单例
    static let sharedManager = SQLiteManager()
    
    /// 全局数据库访问队列
    var queue: FMDatabaseQueue
    
    /// 如果在 单例的构造函数 加上 private，外部只能通过 shared 成员来访问单例
    private init() {
        
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        path = (path as NSString).stringByAppendingPathComponent(dbName)
        
        print(path)
        
        // path 同样是数据库文件的完整路径
        // 如果数据库不存在，会新建之后，再打开，否则会直接建立
        queue = FMDatabaseQueue(path: path)
        
        // 创建数据表
        createTable()
    }
    
    /// 根据指定的 SQL 查询结果返回结果集
    ///
    /// - parameter sql:      SQL
    /// - parameter finished: 完成回调
    func recordSet(sql: String, finished:(array: [[String: AnyObject]]?)->()) {
        
        queue.inDatabase { (db) -> Void in
            
            guard let rs = db.executeQuery(sql) else {
                finished(array: nil)
                return
            }
            
            var array = [[String: AnyObject]]()
            
            while rs.next() {
                
                var dict = [String: AnyObject]()
                
                let count = rs.columnCount()
                
                for col in 0..<count {
                    // 1> 知道列名
                    let name = rs.columnNameForIndex(col)
                    
                    // 2> 知道数值
                    let value = rs.objectForColumnIndex(col)
                    
                    // 3> 设置字典
                    dict[name] = value
                }
                
                // 将一行完整记录添加到数组
                array.append(dict)
            }
            
            finished(array: array)
        }
    }
    
    /// 创建数据表
    private func createTable() {
        
        // 1. SQL
        let path = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
        let sql = try! String(contentsOfFile: path)
        
        // 2. 执行 SQL - 对于多个 SQL 的执行，最好通过`事务`操作！
        queue.inTransaction { (db, _) -> Void in
            if db.executeStatements(sql) {
                print("创表成功")
            } else {
                print("创表失败")
            }
        }
    }
}