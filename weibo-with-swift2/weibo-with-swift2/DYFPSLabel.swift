////
////  DYFPSLabel.swift
////  weibo-with-swift2
////
////  Created by Doye on 16/1/25.
////  Copyright © 2016年 d0ye. All rights reserved.
////
//
//import UIKit
////import YYKit
//import Foundation
//
//
//
//class DYFPSLabel: UILabel {
//    var link:CADisplayLink?
//    var count:Int
//    var lastTime:NSTimeInterval?
//    var fonts:UIFont?
//    var subFont:UIFont?
//    
//    var llll:NSTimeInterval?
//    
//    var KSize = CGSizeMake(55, 20)
//    
//    override init(var frame: CGRect) {
//        if (frame.size.width == 0 && frame.size.height == 0) {
//            frame.size = KSize
//        }
//        count = 0
//        super.init(frame: frame)
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
//        self.textAlignment = NSTextAlignment.Center
//        self.userInteractionEnabled = false
//        self.backgroundColor = UIColor(white: 0.000, alpha: 0.700)
//        fonts = UIFont(name: "Menlo", size: 14)
//        if let _ = fonts {
//            subFont = UIFont(name: "Menlo", size: 4)
//        }else {
//            fonts = UIFont(name: "Courier", size: 14)
//            subFont = UIFont(name: "Courier", size: 4)
//        }
//        
//        link = CADisplayLink(target: self, selector: "tick:")
//        link?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
//        
//        
//
//    }
//    
//    @objc func tick(let link:CADisplayLink?) {
//        if lastTime == nil {
//            lastTime = link?.timestamp
//            return
//        }
//        count += 1
//        let delta:NSTimeInterval? = (link?.timestamp)! - lastTime!
//        if delta < 1 {
//            return
//        }
//        lastTime = link?.timestamp
//        let fps:Float = count.floatValue / delta!.floatValue
//        count = 0
//        let progress:Float = fps / 60.0
//        let hueValue:Float = 0.27 * (progress - 0.2)
//        let color = UIColor(hue: CGFloat(hueValue), saturation: 1, brightness: 0.9, alpha: 1)
//        var text = NSMutableAttributedString(string: NSString(format:"%d FPS",round(fps)) as String)
//        text.setColor(color, range: NSMakeRange(0, text.length - 3))
//        text.setColor(UIColor.whiteColor(), range: NSMakeRange(text.length - 3, 3))
//        text.font = font
//        text.setFont(subFont, range: NSMakeRange(text.length - 4, 1))
//        self.attributedText = text
//        
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    deinit {
//        link?.invalidate()
//    }
//    
//    override func sizeThatFits(size: CGSize) -> CGSize {
//        return KSize
//    }
//}
//
//
