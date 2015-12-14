//
//  StatusListViewModel.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SDWebImage

class StatusListViewModel {
    
    lazy var statuses = [StatusViewModel]()

    var pulldownCount: Int?
    
    func loadStatus(isPullup: Bool, finished: (error: NSError?)->()) {
        
        var since_id = statuses.first?.status.id ?? 0
        var max_id = 0
        if isPullup {
            max_id = statuses.last?.status.id ?? 0
            since_id = 0
        }
        
        NetworkTools.sharedTools.loadStatus(since_id, max_id: max_id) { (result, error) -> () in
            if error != nil {
                finished(error: error)
                return
            }
            
            guard let array = result?["statuses"] as? [[String: AnyObject]] else {
                print("result errors")
                return
            }
            
            var arrayM = [StatusViewModel]()
            for dict in array {
                arrayM.append(StatusViewModel(status: Status(dict: dict)))
            }
            
            self.pulldownCount = since_id > 0 ? arrayM.count : nil
            
            if max_id > 0 {
                self.statuses += arrayM
            }else {
                self.statuses = arrayM + self.statuses
            }
            finished(error: nil)
        }

    }
    

}

