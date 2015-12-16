//
//  MainViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//TODO  4 Customize Tabbar Version

import UIKit

class DYMainViewController: UITabBarController {
    
    //for set badgeVIew
    weak var homeVC:HomeTableViewController!
    weak var messageVC:MessageTableViewController!
    weak var discoverVC:DiscoverTableViewController!
    weak var profileVC:ProfileTableViewController!
    
    
    
    var mainTabBarItems:[UITabBarItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        addChildViewControllers()
        setUpTabBar()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for tabbarView in self.tabBar.subviews {
            if tabbarView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                tabbarView.removeFromSuperview()
            }
        }
    }
    
    

    private func addChildViewControllers() {
        addChildViewController(HomeTableViewController(), title: "Home", image: "tabbar_home", selectedImage:"tabbar_home_highlight")
        addChildViewController(MessageTableViewController(), title: "Message", image: "tabbar_message_center", selectedImage:"tabbar_message_center_highlight")
        addChildViewController(DiscoverTableViewController(), title: "Discover", image: "tabbar_discover", selectedImage:"tabbar_discover_highlight")
        addChildViewController(ProfileTableViewController(), title: "Profile", image: "tabbar_profile", selectedImage:"tabbar_profile_highlight")
    }
    
    
    
    private func setUpTabBar() {
        
        let tabBar =  DYTabBar(frame: self.tabBar.bounds)
        tabBar.backgroundColor = UIColor.whiteColor()
        
        tabBar.delegate = self
        
        tabBar.tabBarItems = self.mainTabBarItems
        
        self.tabBar.addSubview(tabBar)
        
        
        
    }

    private func addChildViewController(vc: UIViewController, title: String, image: String, selectedImage: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        vc.tabBarItem.badgeValue = "10"//"😄"
        mainTabBarItems.append(vc.tabBarItem)
        
        
        let navVC = UINavigationController(rootViewController: vc)
        self.addChildViewController(navVC)
    }
 
}

extension DYMainViewController: DYTabbarDelegate {
    func TabbarItemDidClicked(index:Int){
        self.selectedIndex = index
    }
}
