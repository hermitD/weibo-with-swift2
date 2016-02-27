//
//  DYVisterView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit


protocol VisitorViewDelegate:class {
    
    func visitorViewWillRegisitor()
    func visitorViewWillLogin()
}

class DYVisitorView: UIView {
    
    weak var delegate: VisitorViewDelegate?
    
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var messageLabel: UILabel = UILabel(title: "?????", color: UIColor.darkGrayColor(), fontSize: 14)
    
    lazy var registerButton: UIButton = UIButton(title: "login", fontSize: 14, color: UIColor.orangeColor(), backImageName: "common_button_white_disable")
//    lazy var registerButton2: UIButton = UIButton(title: "register2", fontSize: 14, color: UIColor.orangeColor(), backImageName: "common_button_white_disable")
    lazy var loginButton: UIButton = UIButton(title: "login2", fontSize: 14, color: UIColor.darkGrayColor(), backImageName: "common_button_white_disable")
    
    func setupInfo(imageName: String?, title: String) {
        
        messageLabel.text = title
        
        if let _imageName = imageName {
            iconView.image = UIImage(named: _imageName)
            homeIconView.hidden = true
            sendSubviewToBack(maskIconView)
        } else {
            startAnim()
        }
    }
    
    private func startAnim() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        //for loop Anim
        anim.removedOnCompletion = false
        
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-60)
        }
        
        homeIconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView.snp_center)
        }
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(35)
        }
        registerButton.snp_makeConstraints { (make) -> Void in
            //make.right.equalTo(messageLabel.snp_right)
            make.centerX.equalTo(messageLabel.snp_centerX)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
//        registerButton2.snp_makeConstraints { (make) -> Void in
//            make.right.equalTo(messageLabel.snp_right)
//            make.top.equalTo(messageLabel.snp_bottom).offset(16)
//            make.width.equalTo(100)
//            make.height.equalTo(35)
//        }
//???  couldn't find a common superview
//        loginButton.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(messageLabel.snp_left)
//            make.top.equalTo(messageLabel.snp_bottom).offset(16)
//            make.width.equalTo(100)
//            make.height.equalTo(35)
//        }
        maskIconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(self.snp_top)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(registerButton.snp_bottom)
        }
        
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        
        
        registerButton.addTarget(self, action: "clickLoginButton", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.addTarget(self, action: "clickLoginButton", forControlEvents: UIControlEvents.TouchUpInside)
        //registerButton2.addTarget(self, action: "clickRegisterButton", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    
    
    
    @objc func clickLoginButton() {
        delegate?.visitorViewWillLogin()
    }
    
    @objc func clickRegisterButton() {
        delegate?.visitorViewWillRegisitor()
    }
    
}
