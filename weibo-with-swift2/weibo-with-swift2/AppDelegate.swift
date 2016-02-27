//
//  AppDelegate.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupAppearance()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        
//        let mainVC = defaultRootViewController() // to Defalut MainViewController
//        self.window!.rootViewController = mainVC
        self.window!.rootViewController = DYMainViewController()
        self.window!.makeKeyAndVisible()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootViewController:", name: DYSwitchRootViewControllerNotification, object: nil)
        return true
    }
    

    func applicationDidEnterBackground(application: UIApplication) {
        StatusDAL.clearCache()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @objc private func switchRootViewController(notification: NSNotification) {
        let vc = (notification.object == nil) ? DYMainViewController() : DYWelcomeVC()
        window?.rootViewController = vc
    }
    
    
    private func defaultRootViewController() ->UIViewController {
        if UserAccountViewModel.sharedAccountViewModel.userLogon {
            return isNewVersion() ? DYNewFeatureViewController() : DYWelcomeVC()
        }
        return MainViewController()
    }
    
    private func isNewVersion() -> Bool {
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        let sandBoxVersionKey = "sandBoxVersionKey"
        let sandBoxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(sandBoxVersionKey)
        NSUserDefaults.standardUserDefaults().setDouble(version, forKey: sandBoxVersionKey)
        return version > sandBoxVersion
        
    }
    
    private func setupAppearance() {

        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        //UITabBar.appearance().setSelectedImageTintColor
        
    }

}

