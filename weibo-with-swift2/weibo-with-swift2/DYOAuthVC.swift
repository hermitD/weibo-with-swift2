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
        
        //not to show the redirectURL
        if !request.URL!.absoluteString.hasPrefix(NetworkTools.sharedTools.redirectURL) {
            return true
        }
        
        if let _query = request.URL?.query where _query.hasPrefix("code=") {
            let code = _query.substringFromIndex("code=".endIndex)
            UserAccountViewModel.sharedAccountViewModel.loadAccessToken(code, finished: { (error) -> () in
                if error != nil {
                    SVProgressHUD.showInfoWithStatus("Net Error")
                    return
                }
                SVProgressHUD.showInfoWithStatus("login suceess")
                NSNotificationCenter.defaultCenter().postNotificationName(DYSwitchRootViewControllerNotification, object: "Hello")
            })
            return false
        }
        
        //close
        return false
    }

}