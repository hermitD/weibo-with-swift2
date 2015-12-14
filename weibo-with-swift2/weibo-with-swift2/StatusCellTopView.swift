//
//  StatusCellTopView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class StatusCellTopView: UIView {
    
    //Lazy must with ensure type not use  //known bug :(
    //https://forums.developer.apple.com/thread/7437#22675
    
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var nameLabel: UILabel = UILabel(title: "D", color: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var memberIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    private lazy var vipIconView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    private lazy var timeLabel: UILabel = UILabel(title: "Just now", color: UIColor.orangeColor(), fontSize: 10)
    private lazy var sourceLabel: UILabel = UILabel(title: "DPhone", color: UIColor.lightGrayColor(), fontSize: 10)
    
    var viewModel: StatusViewModel? {
        didSet {
            //here whether ! or ? could all compiled ...
            iconView.sd_setImageWithURL(viewModel!.userProfileUrl)
            nameLabel.text = viewModel?.status.user?.screen_name
            vipIconView.image = viewModel?.userVipImage
            memberIconView.image = viewModel?.userMemberImage
            timeLabel.text = viewModel?.createAt
            sourceLabel.text = viewModel?.status.source
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = UIColor.whiteColor()
        let sepView = UIView()
        sepView.backgroundColor = UIColor.lightGrayColor()
        addSubview(sepView)
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        sepView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_top)
            make.left.equalTo(snp_left)
            make.right.equalTo(snp_right)
            make.height.equalTo(DYStatusCellMargin)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(sepView.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(snp_left).offset(DYStatusCellMargin)
            make.width.equalTo(DYStatusCellIconWidth)
            make.height.equalTo(DYStatusCellIconWidth)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_top)
            make.left.equalTo(iconView.snp_right).offset(DYStatusCellMargin)
        }
        memberIconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp_top)
            make.left.equalTo(nameLabel.snp_right).offset(DYStatusCellMargin)
        }
        vipIconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView.snp_bottom)
            make.left.equalTo(iconView.snp_right).offset(DYStatusCellMargin)
        }
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(timeLabel.snp_bottom)
            make.left.equalTo(timeLabel.snp_right).offset(DYStatusCellMargin)
        }
    }
}
