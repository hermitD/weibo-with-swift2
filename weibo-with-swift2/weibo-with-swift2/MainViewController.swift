//
//  MainViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//  without Custem Tabbar Version

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        addChildViewControllers()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // make sure button above the centerVC
        setCenterButton()
    }
    
    /**
        add a blank vc so not don't need to calculate the frame for others :)
    */
    private func addChildViewControllers() {
        addChildViewController(HomeTableViewController(), title: "Home", image: "tabbar_home", selectedImage:"tabbar_home_highlight")
        addChildViewController(MessageTableViewController(), title: "Message", image: "tabbar_message_center", selectedImage:"tabbar_message_center_highlight")
        addChildViewController(UIViewController())
        
        addChildViewController(DiscoverTableViewController(), title: "Discover", image: "tabbar_discover", selectedImage:"tabbar_discover_highlight")
        addChildViewController(ProfileTableViewController(), title: "Profile", image: "tabbar_profile", selectedImage:"tabbar_profile_highlight")
    }
    
    //FIXED: selcetedImage make no sense? defalut be blue
    // set UITabBar.appearance().tintColor = UIColor.orangeColor() in AppDelegate
    private func addChildViewController(vc: UIViewController, title: String, image: String, selectedImage: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        vc.tabBarItem.badgeValue = "😄"
        
        
        
        let navVC = UINavigationController(rootViewController: vc)
        self.addChildViewController(navVC)
    }
    
    private func setCenterButton() {
        let count = self.childViewControllers.count
        let w = tabBar.bounds.width / CGFloat(count) - 1
        centerButton.frame = CGRectInset(tabBar.bounds, 2 * w, 0)
        self.tabBar.addSubview(centerButton)
    }
    
    func centerBtnClicked() {
        //shownew thing
        
    }
    // lazy load . load when use it
    private lazy var centerButton: UIButton = {
        let centerBtn = UIButton()
        
        centerBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        centerBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        centerBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        centerBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        centerBtn.addTarget(self, action: "centerBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        return centerBtn

    }()
    

}
