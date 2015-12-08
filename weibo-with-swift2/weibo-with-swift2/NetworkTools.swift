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
    
    var oauthURL: NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectURL)"
        return NSURL(string: urlString)!

    }
    
    
    func loadAccessToken(code: String, finished: RequestFinishedCallBack) {
        let params = ["client_id": appKey,
        "client_secret": appSecret,
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectURL ]
        
        request(.POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: params, finished: finished)
        
//        let params = ["client_id": appKey,
//        "client_secret": appSecret,
//        "grant_type": "authorization_code",
//        "code": code,
//        "redirect_uri": redirectURI]
//        
//        request(.POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: params, finished: finished)
//        
//        // 测试代码
//        //        // 1. 设置响应数据格式为二进制数据 AFN 不会做 JSON 反序列化
//        //        responseSerializer = AFHTTPResponseSerializer()
//        //
//        //        // 2. 测试网络代码 － Swift 开发中，凡是碰到 AnyObject 要想使用，就必须转换！
//        //        request(.POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: params) { (result, error) -> () in
//        //            // result 是一个 NSData
//        //            // 将数据转换成 NSString
//        //            let string = NSString(data: result as! NSData, encoding: NSUTF8StringEncoding)
//        //
//        //            // {"access_token":"2.00ml8IrFKlq63E7ccdbba6c5OotBTD","remind_in":"157679999","expires_in":157679999,"uid":"5365823342"}
//        //            // 提示：JSON 反序列化的时候，如果数字没有引号，转换成 NSNumber，可能会导致 KVC 的崩溃！
//        //            print(string)
//        //        }
    }
    //    private func request(method: RequestMethod, urlString: String, parameters: [String: AnyObject]?, finished: RequestFinishedCallBack) {
    // KNOW [String:AnyObject]? --> from the GET( [AnyObject]?)
    private func request(method: RequestMethod, urlString: String, parameters: [String:AnyObject]?, finished: RequestFinishedCallBack) {
        // KNOW closure nesting be logical clear !! closure or block means outside what let inside doing sth. and it could be outside and outsider be sent ...
        let success = { (task: NSURLSessionDataTask, result: AnyObject) -> () in
            finished(result: result, error: nil)
        }
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> () in
            print(error)
            finished(result: nil, error: error)
        }
        if method == RequestMethod.GET{
            GET(urlString, parameters: parameters, success: success, failure: failure )
        }else if(method == RequestMethod.POST){
            POST(urlString, parameters: parameters, success: success, failure: failure)
        }else{
            print("wrong request method!!")
        }
        
        
        /*
        // 闭包是提前准备好的代码，可以当作参数传递
        let success = { (task: NSURLSessionDataTask, result: AnyObject) -> () in
        finished(result: result, error: nil)
        }
        let failure = { (task: NSURLSessionDataTask, error: NSError) -> () in
        print(error)
        finished(result: nil, error: error)
        }
        
        if method == RequestMethod.GET {
        GET(urlString, parameters: parameters, success: success, failure: failure)
        } else {
        POST(urlString, parameters: parameters, success: success, failure: failure)
        }


        */
    }
    
}
