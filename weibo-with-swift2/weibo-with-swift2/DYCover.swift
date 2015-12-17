//
//  DYCover.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/17.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

protocol DYCoverDelegate:class {
    func coverdidClicked(cover: DYCover)
}


class DYCover: UIView {

    weak var delegate:DYCoverDelegate?
    
    var dimBackground:Bool! {
        didSet {
            if dimBackground == true {
                backgroundColor = UIColor.blackColor()
                alpha = 0.5
            }else {
                backgroundColor = UIColor.clearColor()
                alpha = 1
            }
            
        }
    }
    
    
    class func show() -> DYCover {
        let cover = DYCover(frame: UIScreen.mainScreen().bounds)
        cover.backgroundColor = UIColor.clearColor()
        UIApplication.sharedApplication().keyWindow?.addSubview(cover)
        return cover
    }
}
extension DYCover {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        removeFromSuperview()
        delegate?.coverdidClicked(self)
    }
}
