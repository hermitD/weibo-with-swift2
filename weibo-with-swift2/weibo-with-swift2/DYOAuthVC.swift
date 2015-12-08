//
//  DYOAuthVC.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/8.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SVProgressHUD

class DYOAuthVC: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        self.view = webView
        webView.delegate = self
        title = "loging"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .Plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "autoFill", style: .Plain, target: self, action: "autoFill")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        webView.loadRequest(NSURLRequest(URL: NetworkTools.sharedTools.oauthURL))
    }
    
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value = 'd@doyere.cn';" +
        "document.getElementById('passwd').value = 'qwerasd';"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
    @objc private func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true , completion: nil)
    }
    
}

extension DYOAuthVC: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Failload %@",error)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if !request.URL!.absoluteString.hasPrefix(NetworkTools.sharedTools.redirectURL) {
            return true
        }
        
        if let _query = request.URL?.query where _query.hasPrefix("code=") {
            let code = _query.substringFromIndex("code=".endIndex)
            NetworkTools.sharedTools.loadAccessToken(code, finished: { (result, error) -> () in
                if error != nil {
                    SVProgressHUD.showInfoWithStatus("Net Error ")
                    return
                }
                SVProgressHUD.showInfoWithStatus("login success")
                print(result)
                let account = UserAccount(dict: result as! [String: AnyObject])
                account.saveUserAccount()
            })
            
        }
        return false
    }
    
    
    
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        
//        // 1. 判断完整 URL 字符串中是否包含回调地址，屏蔽百度页面的显示
//        if !request.URL!.absoluteString.hasPrefix(NetworkTools.sharedTools.redirectURI) {
//            return true
//        }
//        
//        // 2. 从回调地址的请求 URL 的 query 中提取 code= 之后的内容 -> 请求码
//        if let query = request.URL?.query where query.hasPrefix("code=") {
//            
//            // 提取请求码
//            let code = query.substringFromIndex("code=".endIndex)
//            
//            print("请求码是 --- " + code)
//            UserAccountViewModel.sharedAccountViewModel.loadAccessToken(code, finished: { (error) -> () in
//                
//                if error != nil {
//                    SVProgressHUD.showInfoWithStatus("您的网络不给力!")
//                    
//                    return
//                }
//                
//                SVProgressHUD.showInfoWithStatus("登录成功")
//                
//                // *** 一定要等待控制器被销毁后，再发送通知
//                self.dismissViewControllerAnimated(false, completion: { () -> Void in
//                    // 控制器被销毁后再执行的代码
//                    NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootViewControllerNotification, object: "Welcome")
//                })
//                
//            })
//            return false
//        }
//        
//        close()
//        return false
//    }
//    
}
