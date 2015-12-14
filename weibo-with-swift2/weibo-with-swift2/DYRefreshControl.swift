//
//  DYRefreshControl.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/14.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

private let DYRefreshControlOffset: CGFloat = -60

class DYRefreshControl: UIRefreshControl {

    override func endRefreshing() {
        super.endRefreshing()
        
        refreshView.stopLoadingAnim()
    }
    
    //pull down y-- pull up y++
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if frame.origin.y > 0 {
            return
        }
        
        if refreshing {
            refreshView.startLoadingAnim()
            return
        }
        
        if frame.origin.y < DYRefreshControlOffset && !refreshView.rotateFlag {
            refreshView.rotateFlag = true
        } else if frame.origin.y >= DYRefreshControlOffset && refreshView.rotateFlag {
            refreshView.rotateFlag = false
        }
    }
    
    // MARK: - 构造函数
    override init() {
        super.init()
        
        setupUI()
    }
    
    deinit {
        // 注销监听
        self.removeObserver(self, forKeyPath: "frame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        tintColor = UIColor.clearColor()
        
        addSubview(refreshView)
        
        refreshView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(snp_center)
            make.width.equalTo(refreshView.bounds.width)
            make.height.equalTo(refreshView.bounds.height)
        }
        
        self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
    }
    
    private lazy var refreshView = DYRefreshView.refreshView()
}

class DYRefreshView: UIView {
    
    var rotateFlag = false {
        didSet {
            rotateTipIcon()
        }
    }
    
    @IBOutlet weak var loadingIcon: UIImageView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipIcon: UIImageView!

    class func refreshView() -> DYRefreshView {
        return NSBundle.mainBundle().loadNibNamed("DYRefreshView", owner: nil, options: nil)[0] as! DYRefreshView
    }
    
    private func rotateTipIcon() {
        var angle = CGFloat(M_PI)
        angle += rotateFlag ? -0.001 : 0.001
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.tipIcon.transform = CGAffineTransformRotate(self.tipIcon.transform, angle)
        }
    }
    
    private func startLoadingAnim() {
        
        let keyPath = "transform.rotation"
        
        if loadingIcon.layer.animationForKey(keyPath) != nil {
            return
        }
        
        tipView.hidden = true
        
        let anim = CABasicAnimation(keyPath: keyPath)
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.5
        anim.removedOnCompletion = false
        
        loadingIcon.layer.addAnimation(anim, forKey: keyPath)
    }
    
    private func stopLoadingAnim() {
        tipView.hidden = false
        
        loadingIcon.layer.removeAllAnimations()
    }}
