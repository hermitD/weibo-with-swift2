//
//  DYBadgeView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/16.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

//TODO Font all sets to const size? use other tech to change?
class DYBadgeView: UIButton {

    var badgeValue:String! {
        didSet {
            if badgeValue == "0" {
                self.hidden = true
            }else {
                self.hidden = false
            }
            
            let attrs = [ NSFontAttributeName : UIFont.systemFontOfSize(11)]
            let size = badgeValue.sizeWithAttributes(attrs)
            if size.width > self.width {
                self.setImage(UIImage(named: "new_dot"), forState: .Normal)
                self.setTitle(nil, forState: .Normal)
                self.setBackgroundImage(nil, forState: .Normal)
            }else {
                self.setBackgroundImage(UIImage(named: "main_badge"), forState: .Normal)
                self.setTitle(badgeValue, forState: .Normal)
                self.setImage(nil, forState: .Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.userInteractionEnabled = false
        self.setBackgroundImage(UIImage(named: "main_badge"), forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(11)
        self.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
