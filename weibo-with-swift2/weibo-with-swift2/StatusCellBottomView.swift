//
//  StatusCellBottomView.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/11.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {
    private lazy var forwardButton: UIButton = UIButton(title: " retweet",fontSize: 12,color: UIColor.darkGrayColor(),imageName: "timeline_icon_retweet")
    private lazy var commentButton: UIButton = UIButton(title: " comment",fontSize: 12,color: UIColor.darkGrayColor(),imageName: "timeline_icon_comment")
    private lazy var likeButton: UIButton = UIButton(title: " Like",fontSize: 12,color: UIColor.darkGrayColor(),imageName: "timeline_icon_unlike")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        addSubview(forwardButton)
        addSubview(commentButton)
        addSubview(likeButton)
        let sep1 = sepView()
        let sep2 = sepView()
        addSubview(sep1)
        addSubview(sep2)
        
        forwardButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_top)
            make.left.equalTo(snp_left)
            make.bottom.equalTo(snp_bottom)
        }
        commentButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(forwardButton.snp_top)
            make.left.equalTo(forwardButton.snp_right)
            make.width.equalTo(forwardButton.snp_width)
            make.bottom.equalTo(snp_bottom)
        }
        likeButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(commentButton.snp_top)
            make.left.equalTo(commentButton.snp_right)
            make.width.equalTo(commentButton.snp_width)
            make.bottom.equalTo(snp_bottom)
            make.right.equalTo(snp_right)
        }
        sep1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(forwardButton.snp_right)
            make.width.equalTo(0.5)
            make.height.equalTo(snp_height).multipliedBy(0.6)
            make.centerY.equalTo(snp_centerY)
        }
        sep2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentButton.snp_right)
            make.width.equalTo(0.5)
            make.height.equalTo(snp_height).multipliedBy(0.6)
            make.centerY.equalTo(snp_centerY)
        }
    }
    
    private func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.darkGrayColor()
        
        return v
    }
}
