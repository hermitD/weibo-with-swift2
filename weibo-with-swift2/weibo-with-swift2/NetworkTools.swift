//
//  NetworkTools.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/8.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    
    //be morden so use this
    typealias RequestFinishedCallBack = (result: AnyObject?, error: NSError?) -> ()

    
    //singleton
    static let sharedTools:NetworkTools = {
        let instance = NetworkTools(baseURL: nil)
        //
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
    
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
    
    func loadUserInfo(uid: String, finished: RequestFinishedCallBack) {
        guard var params = tokenParams else{
            finished(result: nil, error: NSError(domain: "cn.doyere.error", code: 404, userInfo: ["message": "token is nil"]))
            return
        }
            params["uid"] = uid
            
            request(.GET, urlString: "https://api.weibo.com/2/users/show.json", parameters: params, finished: finished)
    }
    
    
    func loadAccessToken(code: String, finished: RequestFinishedCallBack) {
        let params = ["client_id": appKey,
        "client_secret": appSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectURL ]
        
        request(.POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: params, finished: finished)
        
    }
    
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
    
    
    //    private func request(method: RequestMethod, urlString: String, parameters: [String: AnyObject]?, finished: RequestFinishedCallBack) {
    // KNOW [String:AnyObject]? --> from the GET( [AnyObject]?)
    private func request(method: RequestMethod, urlString: String, parameters: [String:AnyObject]?, finished: RequestFinishedCallBack) {
        // KNOW closure nesting be logical clear !! closure or block means outside what let inside doing sth. and it could be outside and outsider be sent ...
        let success = { (task: NSURLSessionDataTask, result: AnyObject?) -> () in
            finished(result: result, error: nil)
        }
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> () in
            print(error)
            finished(result: nil, error: error)
        }
        if method == RequestMethod.GET{
            //GET(urlString, parameters: parameters, success: success, failure: failure)
            GET(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        }else if(method == RequestMethod.POST){
            //POST(urlString, parameters: parameters, success: success, failure: failure)
            POST(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
                    }else{
            print("Unhandle request method!!")
        }

    }
    
}
