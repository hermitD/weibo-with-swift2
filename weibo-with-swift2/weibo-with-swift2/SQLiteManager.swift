//
//  SQLiteManager.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import Foundation
import FMDB

/*
error: include of non-modular header inside framework module 'FMDB.FMDatabase'
#import "sqlite3.h"

using solution https://github.com/ccgus/fmdb/issues/309 -> davidman


Installing FMDB (2.5)
Installing SQLCipher (3.3.1)

*/


private let dbName = "my.db"
class SQLiteManager {
    
    static let sharedManager = SQLiteManager()
    
    var queue: FMDatabaseQueue
    
    private init() {
        
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        path = (path as NSString).stringByAppendingPathComponent(dbName)
        
        //print(path)
        
        queue = FMDatabaseQueue(path: path)
        
        createTable()
    }
    
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
                    let name = rs.columnNameForIndex(col)
                    
                    let value = rs.objectForColumnIndex(col)
                    dict[name] = value
                }
                array.append(dict)
            }
            
            finished(array: array)
        }
    }
    
    private func createTable() {
        
        let path = NSBundle.mainBundle().pathForResource("db.sql", ofType: nil)!
        let sql = try! String(contentsOfFile: path)
        
        queue.inTransaction { (db, _) -> Void in
            if db.executeStatements(sql) {
            } else {
            }
        }
    }
}