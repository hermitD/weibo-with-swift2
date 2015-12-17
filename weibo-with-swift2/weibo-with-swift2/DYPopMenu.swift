//
//  DYPopMenu.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/17.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class DYPopMenu: UIImageView {
    
    
    weak var thecontentView: UIView?
    weak var contentView: UIView? {
        set {
            if let cView = thecontentView {
                cView.removeFromSuperview()
            }
            newValue!.backgroundColor = UIColor.clearColor()
            thecontentView = newValue
            addSubview(newValue!)
        }
        get {
            return thecontentView
        }
    }
    
    
    class func hide() {
        for view in (UIApplication.sharedApplication().keyWindow?.subviews)! {
            if view.isKindOfClass(self) {
                view.removeFromSuperview()
            }
        }
    }
    
    class func showInRect(rect: CGRect) -> DYPopMenu {
        let menu = DYPopMenu(frame: rect)
        menu.userInteractionEnabled = true
        let menuImage = UIImage(named: "popover_background")
        menuImage?.stretchHalf()
        menu.image = menuImage
        
        UIApplication.sharedApplication().keyWindow?.addSubview(menu)
        return menu
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let y:CGFloat = 9
        let margin:CGFloat = 9
        let x = margin
        let w:CGFloat = width() - 2 * margin
        let h:CGFloat = height() - y - margin
        
        contentView?.frame = CGRectMake(x, y, w, h)
    }

}
