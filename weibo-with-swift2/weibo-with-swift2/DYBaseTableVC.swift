//
//  DYBaseTableVC.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//  Since all VCs have two type of View(logined or not) and the unlogin is similar made it's logic to be Base

import UIKit

class DYBaseTableVC: UITableViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    var isLogin:Bool = false
    var visitorView:DYVisitorView?
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView() {
        visitorView = DYVisitorView()
        self.view = visitorView
        visitorView?.delegate = self
        //set delegate
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .Plain, target: self, action: "visitorViewDidRegister")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .Plain, target: self, action: "visitorViewDidLogin")
        
    }
    
    @objc func visitorViewDidRegister() {
        NSLog("Register")
    }
    
    @objc func visitorViewDidLogin() {
        //NSLog("Login")
        if UserAccountViewModel.sharedAccountViewModel.userAccount != nil {
            print("Loged: ) ")
            return
        }
        let vc = DYOAuthVC()
        let nav = UINavigationController(rootViewController: vc)
        
        presentViewController(nav, animated: true, completion: nil)
        
    }
    
}
//VisitorViewDelegate
extension DYBaseTableVC: VisitorViewDelegate {
    
    func visitorViewWillRegisitor() {
        visitorViewDidRegister()
    }
    func visitorViewWillLogin() {
        visitorViewDidLogin()
    }
}