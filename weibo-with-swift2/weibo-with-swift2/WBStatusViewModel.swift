//
//  WBStatusViewModel.swift
//  weibo-with-swift2
//
//  Created by Doye on 16/2/25.
//  Copyright © 2016年 d0ye. All rights reserved.
//

import UIKit

import UIKit
import SDWebImage

class WBStatusListViewModel {
    
    lazy var statuses = [StatusViewModel]()
    
    var pulldownCount: Int?
    
    func loadStatus(isPullup: Bool, finished: (error: NSError?)->()) {
        
        var since_id = statuses.first?.status.id ?? 0
        var max_id = 0
        if isPullup {
            max_id = statuses.last?.status.id ?? 0
            since_id = 0
        }
        StatusDAL.loadStatus(since_id, max_id: max_id) { (array, error) -> () in
            if error != nil {
                finished(error: error)
                return
            }
            var arrayM = [StatusViewModel]()
            for dict in array! {
                arrayM.append(StatusViewModel(status: Status(dict: dict)))
            }
            self.pulldownCount = since_id > 0 ? arrayM.count : nil
            
            if max_id > 0 {
                self.statuses += arrayM
            }else {
                self.statuses = arrayM + self.statuses
            }
            
            self.cacheWebImage(arrayM, finished: finished)
            
        }
    }
    private func cacheWebImage(array: [StatusViewModel], finished: (error: NSError?)->()) {
        
        let group = dispatch_group_create()
        var dataLength = 0
        
        for vm in array {
            
            if vm.thumbnailUrls?.count != 1 {
                continue
            }
            
            let url = vm.thumbnailUrls![0]
            //print("cache 1 pic \(url)")
            
            dispatch_group_enter(group)
            SDWebImageManager.sharedManager().downloadImageWithURL(url, options: [], progress: nil, completed: { (image, _, _, _, _) -> Void in
                
                if let img = image,
                    data = UIImagePNGRepresentation(img) {
                        dataLength += data.length
                }
                
                dispatch_group_leave(group)
            })
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            //print("cache over \(dataLength / 1024) K")
            
            finished(error: nil)
        }
    }
    
}

