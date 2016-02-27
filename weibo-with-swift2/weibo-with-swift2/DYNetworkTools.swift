//
//  DYNetworkTools.swift
//  weibo-with-swift2
//
//  Created by Doye on 16/2/26.
//  Copyright © 2016年 d0ye. All rights reserved.
//

import UIKit
import Alamofire

class DYNetworkTools: NSObject {
    
    private let appKey = "2730049225"
    private let appSecret = "185cecdbf419ae8fa04971ef11e0a2ac"
    let redirectURL = "http://www.baidu.com"
    private var tokenParams: [String: AnyObject]? {
        guard let token = UserAccountViewModel.sharedAccountViewModel.userAccount?.access_token else{
            return nil
        }
        return ["access_token": token]
    }
    
    var oauthURL: NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectURL)"
        return NSURL(string: urlString)!
        
    }
    
//    Alamofire.request(.GET, urlString).responseJSON { (response) -> Void in  //[unowned self]
//    guard let _hotcontents = HotContents(dictionary: response.result.value as! [String: AnyObject]) else {
//    print("json Errors~")
//    return
//    }
//    self.hotContents = _hotcontents
//    
//    
//    self.tableView.reloadData()
//    
//    }
    /*
    func loadStatus(since_id: Int, max_id: Int, finished: RequestFinishedCallBack) {
    guard var params = tokenParams else {
    finished(result: nil, error: NSError(domain: "cn.doyere.error", code: 404, userInfo: ["message": "token is nil"]))
    return
    }
    
    if since_id > 0 {
    params["since_id"] = since_id
    } else if max_id > 0 {
    params["max_id"] = max_id - 1
    }
    
    request(.GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, finished: finished)
    }
*/
//    func loadStatus() {
//        guard let params = tokenParams else {
//            print("no token")
//            return
//        }
//        Alamofire.request(.GET, "https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
//            <#code#>
//        }
//        
//    }
    
}
