//
//  DYWelcomeVC.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/9.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class DYWelcomeVC: UIViewController {
    private lazy var iconView: UIImageView = {
        let _iconView = UIImageView(image: UIImage(named: "avatar_default_big"))
        //set be circle
        _iconView.layer.cornerRadius = 45
        _iconView.layer.masksToBounds = true
        return _iconView
    }()
    private lazy var messageLabel: UILabel = UILabel(title: "Welcome back", color: UIColor.darkGrayColor(), fontSize: 18)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconView.sd_setImageWithURL(UserAccountViewModel.sharedAccountViewModel.avatarUrl)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //KNOW if set Constraints to set layout ,Then dont set it frame manully
        //"contraints system "auto collect the contraints and call layoutSubViews to update
        iconView.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-view.bounds.height + 160)
        }
        messageLabel.alpha = 0
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            //layoutIfNeed() manully update the contraints make it works
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageLabel.alpha = 1
                    }, completion: { (_) -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(DYSwitchRootViewControllerNotification, object: nil)
                })
        }
    }
    
    // ??? why should do this in here ? to override the loadView -> consider constraints?
    override func loadView() {
        view = UIImageView(image: UIImage(named: "ad_background"))
        view.addSubview(iconView)
        view.addSubview(messageLabel)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-160)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
        }
        
        //set to transparent
        messageLabel.alpha = 0
    }
}
