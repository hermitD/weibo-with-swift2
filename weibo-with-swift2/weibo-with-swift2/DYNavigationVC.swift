//
//  DYNavigationVC.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/17.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class DYNavigationVC: UINavigationController {
    
//    var popDelegate = {
//        
//        return self.interactivePopGestureRecognizer.delegate
//    }()
    /*
    //KNOW for NO OCClass private var once = dispatch_once_t()
    
    class MyObject {
        init () {
            dispatch_once(&once) {
                // Do stuff
            }
*/
    override class func initialize() {
        if #available(iOS 9.0, *) {
            let item = UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([self])
            let titleAttr = [NSForegroundColorAttributeName:UIColor.orangeColor()]
            item.setTitleTextAttributes(titleAttr, forState: .Normal)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        let fpsLabel = YYFPSLabel()
        fpsLabel.sizeToFit()
        fpsLabel.bottom = self.view.height - 47
        fpsLabel.left = 12
        fpsLabel.alpha = 0
        
        fpsLabel.alpha = 1
        view.addSubview(fpsLabel)
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count != 0 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_back", highImage: "navigationbar_back_highlighted", target: self, action: "backToPre")
            
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_more", highImage: "navigationbar_more_highlighted", target: self, action: "backToRoot")
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
    
    @objc private func backToPre() {
        popViewControllerAnimated(true)
    }
    
    @objc private func backToRoot() {
        popToRootViewControllerAnimated(true)
    }
    
}


extension DYNavigationVC : UINavigationControllerDelegate {
    
}