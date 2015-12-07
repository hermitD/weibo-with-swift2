//
//  MainViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//TODO  4 Customize Tabbar Version

import UIKit

class DYMainViewController: UITabBarController {
    var tabBarItems:[UITabBarItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        addChildViewControllers()
        setUpTabBar()
        
    }
    
    
    
    private func addChildViewControllers() {
        addChildViewController(HomeTableViewController(), title: "Home", image: "tabbar_home", selectedImage:"tabbar_home_highlight")
        addChildViewController(MessageTableViewController(), title: "Message", image: "tabbar_message_center", selectedImage:"tabbar_message_center_highlight")
        addChildViewController(DiscoverTableViewController(), title: "Discover", image: "tabbar_discover", selectedImage:"tabbar_discover_highlight")
        addChildViewController(ProfileTableViewController(), title: "Profile", image: "tabbar_profile", selectedImage:"tabbar_profile_highlight")
    }
    
    
    
    private func setUpTabBar() {
        /*
        // 自定义tabBar
        CZTabBar *tabBar = [[CZTabBar alloc] initWithFrame:self.tabBar.bounds];
        tabBar.backgroundColor = [UIColor whiteColor];
        
        // 设置代理
        tabBar.delegate = self;
        
        // 给tabBar传递tabBarItem模型
        tabBar.items = self.items;
        
        // 添加自定义tabBar
        [self.tabBar addSubview:tabBar];
        
        // 移除系统的tabBar
        //[self.tabBar removeFromSuperview];

        */
        
        
        let tabBar =  DYTabar(frame: self.tabBar.frame)
        tabBar.backgroundColor = UIColor.blackColor()
        
        tabBar.tabBarItems = self.tabBarItems
        self.tabBar.addSubview(tabBar)
        
        
        
    }
    /**
    Description
    
    - parameter vc:       associate vc
    - parameter title:    title string
    - parameter iconName: iconName stirng
    */
    //FIXED: selcetedImage make no sense? defalut be blue
    // set UITabBar.appearance().tintColor = UIColor.orangeColor() in AppDelegate
    private func addChildViewController(vc: UIViewController, title: String, image: String, selectedImage: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        vc.tabBarItem.badgeValue = "😄"
        tabBarItems?.append(vc.tabBarItem)
        
        let navVC = UINavigationController(rootViewController: vc)
        self.addChildViewController(navVC)
    }
 
}
