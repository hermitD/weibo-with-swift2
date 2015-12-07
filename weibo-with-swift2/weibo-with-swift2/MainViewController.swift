//
//  MainViewController.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

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
        add a blank vc so not don't need to calculate the frame
    */
    private func addChildViewControllers() {
        addChildViewController(HomeTableViewController(), title: "Home", iconName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "Message", iconName: "tabbar_message_center")
        addChildViewController(UIViewController())
        //addChildViewController(DiscoverTableViewController(), title: "Discover", iconName: "tabbar_discover")
        
        addChildViewController(DiscoverTableViewController(), title: "Discover", iconName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "Profile", iconName: "tabbar_profile")
    }
    /**
    Description
    
    - parameter vc:       associate vc
    - parameter title:    title string
    - parameter iconName: iconName stirng
    */
    
    private func addChildViewController(vc: UIViewController, title: String, iconName: String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: iconName)
        
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
