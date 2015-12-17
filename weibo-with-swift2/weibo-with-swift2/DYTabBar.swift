//
//  DYTabar.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//TODO 4 Customize Tabbar Version

import UIKit

/*
    传入[UITabBarItem],给View自定义的buttons提供参数（图片／文字，badage值）
*/

protocol DYTabbarDelegate:class {
//    func visitorViewWillRegisitor()
//    func visitorViewWillLogin()
    func TabbarItemDidClicked(index:Int) //这个是给外界传的，通过被点击，传给外界相应的值delegate
    //外界实现这个delegate,设置这个delegate然后就可以拿到这里的参数值，去设置不同的View(特指TabbarView)
}

class DYTabBar: UIView {
    
    var tabBarItems: [UITabBarItem]! {
        didSet{
            for item in tabBarItems {
                var btn = DYTabbarItem(type: .Custom)
                btn.item = item
                btn.tag = selfTabBarItems.count //?? 0
                btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                if (btn.tag == 0) {
                    btnClick(btn)
                }
                self.addSubview(btn);
                selfTabBarItems.append(btn)
                
            }
        }
    }
    //KNOW OPTIONAL [] array needs to init with [],if ? then could not append a value to nil

    var selfTabBarItems: [DYTabbarItem] = []
    
    weak var selectedButton: DYTabbarItem?
    
    weak var delegate: DYTabbarDelegate?
    
    private lazy var plusButton:UIButton = {
        let plusBtn = UIButton(type: UIButtonType.Custom)
        
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        //plusBtn.addTarget(self, action: "centerBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        plusBtn.sizeToFit()
        self.addSubview(plusBtn)
        
        return plusBtn
    }()

    
    func btnClick(button: DYTabbarItem) {
        selectedButton?.selected = false
        button.selected = true
        //KNOW OPTIONAL when set value use without !/?
        selectedButton = button
        delegate?.TabbarItemDidClicked(button.tag)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        
        var btnX:CGFloat = 0
        let btnY:CGFloat = 0
        let tabbarCount = selfTabBarItems.count ?? 0
        let btnW = w / CGFloat(tabbarCount + 1)
        let btnH = self.bounds.size.height
        
        for (index,tabBarItem) in selfTabBarItems.enumerate() {
            var _index = index
            if index >= 2 {
                _index = index + 1
            }
//            }else if index == 3 {
//                _index = 4
//            }
            
            btnX = CGFloat(_index) * btnW
            tabBarItem.frame = CGRectMake(btnX, btnY, btnW, btnH)
            self.plusButton.center = CGPointMake(w * 0.5 , h * 0.5)
        }
        
    }
    
}
