//
//  DYTabbarItem.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/16.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit


let TabBarImageRidio = CGFloat(0.7)

class DYTabbarItem: UIButton {

    private lazy var badgeView: DYBadgeView = {
        var btn = DYBadgeView(type: UIButtonType.Custom)
        self.addSubview(btn)
        return btn
    }()
    //TODO use override didset to replace kvo? kvo完成两个属性的强关联
    var item: UITabBarItem! {
        didSet {
            self.observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
            item.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New, context: nil)
            item.addObserver(self, forKeyPath: "image", options: NSKeyValueObservingOptions.New, context: nil)
            item.addObserver(self, forKeyPath: "selectedImage", options: NSKeyValueObservingOptions.New, context: nil)
            item.addObserver(self, forKeyPath: "badgeView", options: NSKeyValueObservingOptions.New, context: nil)
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Selected)
        
        self.imageView?.contentMode = UIViewContentMode.Center
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.setTitle(item.title, forState: UIControlState.Normal)
        self.setImage(item.image, forState: UIControlState.Normal)
        self.setImage(item.selectedImage, forState: UIControlState.Normal)
        self.badgeView.badgeValue = item.badgeValue
    }
    //TODO using constrains replacing this
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageX = CGFloat(0)
        let imageY = CGFloat(0)
        let imageW = self.bounds.size.width
        let imageH = self.bounds.size.height * TabBarImageRidio
        self.imageView?.frame = CGRectMake(imageX, imageY, imageW, imageH)
        
        let titleX = CGFloat(0)
        let titleY = imageH - CGFloat(3)
        let titleW = self.bounds.size.width
        let titleH = self.bounds.size.height - titleY
        self.titleLabel?.frame = CGRectMake(titleX, titleY, titleW, titleH)
        
        self.badgeView.setX(self.frame.width - self.badgeView.frame.width - 10)
        self.badgeView.setY(0)
    }
    
}
