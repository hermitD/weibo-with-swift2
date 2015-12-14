//
//  StatusRetweetedCell.swift
//  weibo-with-swift2
//
//  Created by Doye on 15/12/10.
//  Copyright © 2015年 d0ye. All rights reserved.
//

import UIKit
import SnapKit
import FFLabel

class StatusRetweetedCell:StatusCell {
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        return button
    }()
    
    private lazy var retweetedLabel: FFLabel = FFLabel(title: "retweet",
        color: UIColor.darkGrayColor(),
        fontSize: 14,
        layoutWidth: UIScreen.mainScreen().bounds.width - 2 * DYStatusCellMargin)
    override var viewModel: StatusViewModel? {
        //super's didSet will autocall first ,don't need to call
        didSet {
            let statusText = viewModel?.retweetedText ?? ""
            retweetedLabel.text = statusText//EmoticonViewModel.sharedViewModel.emoticonText(statusText, font: retweetedLabel.font)
            
            pictureView.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(pictureView.bounds.width)
                make.height.equalTo(pictureView.bounds.height)
                
                let offset = (pictureView.bounds.height == 0) ? 0 : DYStatusCellMargin
                make.top.equalTo(retweetedLabel.snp_bottom).offset(offset)
            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        backButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        retweetedLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(backButton.snp_top).offset(DYStatusCellMargin)
            make.left.equalTo(backButton.snp_left).offset(DYStatusCellMargin)
        }
        
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLabel.snp_bottom).offset(DYStatusCellMargin)
            make.left.equalTo(retweetedLabel.snp_left)
            make.width.equalTo(290)
            make.height.equalTo(290)
        }
        
        retweetedLabel.labelDelegate = self
    }
    
    

}
