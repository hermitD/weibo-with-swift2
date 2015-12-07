//
//  DYTabar.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//TODO 4 Customize Tabbar Version

import UIKit

class DYTabar: UIView {
    
    var tabBarItems:[UITabBarItem]?
    //delegate
    
    
    
    private lazy var plusButton:UIButton = {
        let plusBtn = UIButton(type: UIButtonType.Custom)
        
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        //plusBtn.addTarget(self, action: "centerBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        plusBtn.sizeToFit()
        
        return plusBtn
    }()
    
    private var buttons:[UIButton]?
    private weak var selectedButton:UIButton?
    

}
