//
//  DYVisterView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/7.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit


protocol VisitorViewDelegate {
    
    func visitorViewWillRegisitor()
    func visitorViewWillLogin()
}

//TODO 理清动画逻辑，熟悉SnapKit
class DYVisitorView: UIView {
    
    var delegate:VisitorViewDelegate!
    func setupInfo(imageName: String?, title: String) {
        
        messageLabel.text = title
        
        // 判断是否指定了图像，不是首页
        if imageName != nil {
            iconView.image = UIImage(named: imageName!)
            homeIconView.hidden = true
            sendSubviewToBack(maskIconView)
        } else {    // 如果是首页，播放动画
            startAnim()
        }
    }
    
    /// 开始动画
    private func startAnim() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        
        // 通常应用在循环播放的动画，动画会绑定在图层上，不会被销毁
        // 提示：当视图被销毁时，动画会一起被销毁，不需要考虑额外的操作
        anim.removedOnCompletion = false
        
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    
    // MARK: - 设置界面
    /// UIView 的指定构造函数 - 纯代码开发会调用
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    /// initWithCoder - 使用 Stroyboard ／ XIB 开发会调用
    required init?(coder aDecoder: NSCoder) {
        // 会让代码直接崩溃！- 通常用纯代码开发，不希望这个类被 Storyboard 使用！
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    /// 设置界面
    private func setupUI() {
        // 1. 添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2. 设置布局 - 约束需要添加到父视图上
        // 提示：使用纯代码布局，最好让所有的控件，顺序参照某一个控件
        // 1> 图标
        // 要设置 iconView 的约束，闭包中的 make 理解成约束
        iconView.snp_makeConstraints { (make) -> Void in
            // centerX 本身是约束的属性，snp_centerX 取出约束的数值
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-60)
        }
        
        // 2> 小房子
        homeIconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView.snp_center)
        }
        // 3> 消息文字
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(35)
        }
        // 4> 注册按钮
        registerButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(messageLabel.snp_left)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        // 5> 登录按钮
        loginButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(messageLabel.snp_right)
            make.top.equalTo(messageLabel.snp_bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        // 6> 遮罩视图 VFL
        maskIconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(self.snp_top)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(registerButton.snp_bottom)
        }
        
        // 设置背景颜色 R = G = B 灰度图
        // 如何提高程序的性能：如果能够使用颜色就不要使用图片，绝大多数的素材，都是灰度或者单色
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        
        
        registerButton.addTarget(self, action: "clickRegisterButton", forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.addTarget(self, action: "clickLoginButton", forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    // MARK: - 懒加载控件
    /// 图标 - 如果使用 image 创建 UIImageView，大小默认就是图像大小
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    /// 遮罩图片
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    /// 小房子
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 描述文字
    private lazy var messageLabel: UILabel = UILabel(title: "?????", color: UIColor.darkGrayColor(), fontSize: 14)
    //关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜
    
    /// 注册按钮
    lazy var registerButton: UIButton = UIButton(title: "注册", fontSize: 14, color: UIColor.orangeColor(), backImageName: "common_button_white_disable")
    /// 登录按钮
    lazy var loginButton: UIButton = UIButton(title: "登录", fontSize: 14, color: UIColor.darkGrayColor(), backImageName: "common_button_white_disable")
    
    
    
    
    func clickLoginButton() {
        delegate?.visitorViewWillLogin()
    }
    
    func clickRegisterButton() {
        delegate?.visitorViewWillRegisitor()
    }
    
}
